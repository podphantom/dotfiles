return {
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local jdtls = require("jdtls")
            local home = os.getenv("HOME")
            local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
            local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

            -- ===== Debug Bundles =====
            local bundles = {}

            -- java-debug-adapter
            local debug_jar = vim.fn.glob(
                mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1
            )
            if debug_jar ~= "" then
                table.insert(bundles, debug_jar)
            end

            -- java-test (optional)
            local java_test_jars = vim.split(
                vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", 1), "\n", { trimempty = true }
            )
            vim.list_extend(bundles, java_test_jars)

            -- ===== JDTLS Config =====
            local config = {
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xms1g",
                    "-Xmx4g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
                    "-configuration", jdtls_path .. "/config_linux",
                    "-data", vim.fn.stdpath("cache") .. "/jdtls/" ..
                             vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
                },

                root_dir = require("jdtls.setup").find_root({
                    ".git", "mvnw", "gradlew", "pom.xml", "build.gradle",
                }),

                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        contentProvider = { preferred = "fernflower" },
                        eclipse = { downloadSources = true },
                        maven   = { downloadSources = true },
                        referencesCodeLens = { enabled = true },
                        references         = { includeDecompiledSources = true },
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                        },
                        completion = {
                            favoriteStaticMembers = {
                                "org.hamcrest.MatcherAssert.assertThat",
                                "org.hamcrest.Matchers.*",
                                "org.junit.jupiter.api.Assertions.*",
                                "java.util.Objects.requireNonNull",
                                "java.util.Objects.requireNonNullElse",
                                "org.mockito.Mockito.*",
                            },
                        },
                        sources = {
                            organizeImports = {
                                starThreshold       = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                    },
                },

                init_options = {
                    bundles = bundles,
                },

                on_attach = function(_, bufnr)
                    local opts = { buffer = bufnr, silent = true }

                    -- Organize Imports
                    vim.keymap.set("n", "<leader>oi", jdtls.organize_imports,
                        vim.tbl_extend("force", opts, { desc = "Organize Imports" }))

                    -- Extract variable / method
                    vim.keymap.set({ "n", "v" }, "<leader>ev", jdtls.extract_variable,
                        vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
                    vim.keymap.set({ "n", "v" }, "<leader>em", jdtls.extract_method,
                        vim.tbl_extend("force", opts, { desc = "Extract Method" }))

                    -- Enable DAP for Java
                    jdtls.setup_dap({ hotcodereplace = "auto" })

                    -- Setup main class configs after JDTLS is fully initialised
                    vim.defer_fn(function()
                        pcall(require("jdtls.dap").setup_dap_main_class_configs)
                    end, 1500)
                end,
            }

            jdtls.start_or_attach(config)
        end,
    },
}
