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

            -- ===== Bundles cho Debug =====
            local bundles = {
                vim.fn.glob(mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
            }

            -- Thêm java-test (nếu đã cài)
            local java_test_bundles = vim.split(
                vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", true),
                "\n"
            )
            if #java_test_bundles > 0 then
                vim.list_extend(bundles, java_test_bundles)
            end

            local config = {
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
                    "-configuration", jdtls_path .. "/config_linux",
                    "-data", vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
                },

                root_dir = require("jdtls.setup").find_root({
                    ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
                }),

                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        contentProvider = { preferred = "fernflower" },
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
                                starThreshold = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                    },
                },

                -- Quan trọng: load debug adapter
                init_options = {
                    bundles = bundles,
                },

                on_attach = function(client, bufnr)
                    -- Auto import
                    vim.keymap.set("n", "<leader>oi", function()
                        jdtls.organize_imports()
                    end, { buffer = bufnr, desc = "Organize Imports" })

                    -- Bật DAP
                    require("jdtls").setup_dap({ hotcodereplace = "auto" })

                    -- Đợi JDTLS load xong rồi mới setup main class configs
                    vim.defer_fn(function()
                        require("jdtls.dap").setup_dap_main_class_configs()
                    end, 1500)
                end,
            }

            jdtls.start_or_attach(config)
        end,
    },
}
