return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
        "mfussenegger/nvim-dap",
        "neovim/nvim-lspconfig",
    },
    config = function()
        local function setup_jdtls()
            local jdtls = require("jdtls")

            local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
            local jdtls_path = mason_path .. "/jdtls"

            -- Find launcher jar and lombok jar
            local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, 1)[1]
            local config_dir = jdtls_path .. "/config_linux"
            local lombok_jar = jdtls_path .. "/lombok.jar"

            -- Find java debug adapter and test runner jars
            local bundles = {}
            local java_debug_jar = vim.fn.glob(mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, 1)[1]
            if java_debug_jar and java_debug_jar ~= "" then
                table.insert(bundles, java_debug_jar)
            end

            local java_test_jars = vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", true, true)
            for _, jar in ipairs(java_test_jars) do
                if jar ~= "" then
                    table.insert(bundles, jar)
                end
            end

            -- Workspace folder setup per project
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

            -- Root pattern detection
            local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }) or vim.fn.getcwd()

            -- Capabilities from blink.cmp if available
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local has_blink, blink = pcall(require, "blink.cmp")
            if has_blink then
                capabilities = blink.get_lsp_capabilities(capabilities)
            end

            local config = {
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-DOSGI_bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.level=ALL",
                    "-Xmx1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-javaagent:" .. lombok_jar,
                    "-jar", launcher_jar,
                    "-configuration", config_dir,
                    "-data", workspace_dir,
                },
                root_dir = root_dir,
                capabilities = capabilities,
                init_options = {
                    bundles = bundles,
                    extendedClientCapabilities = jdtls.extendedClientCapabilities,
                },
                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        contentProvider = { preferred = "fernflower" },
                        completion = {
                            favoriteStaticMembers = {
                                "org.hamcrest.MatcherAssert.assertThat",
                                "org.hamcrest.Matchers.*",
                                "org.hamcrest.CoreMatchers.*",
                                "org.junit.jupiter.api.Assertions.*",
                                "java.util.Objects.requireNonNull",
                                "java.util.Objects.requireNonNullElse",
                                "org.mockito.Mockito.*",
                            },
                            filteredTypes = {
                                "com.sun.*",
                                "io.micrometer.shaded.*",
                                "java.awt.*",
                                "jdk.*",
                                "sun.*",
                            },
                        },
                        sources = {
                            organizeImports = {
                                starThreshold = 9999,
                                staticStarThreshold = 9999,
                            },
                        },
                        codeGeneration = {
                            toString = {
                                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                            },
                            useBlocks = true,
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    -- Setup DAP integration for Java
                    pcall(function()
                        require("jdtls").setup_dap({ hotcodereplace = "auto" })
                    end)

                    -- Keymaps
                    local opts = { buffer = bufnr, silent = true }
                    opts.desc = "Organize Imports"
                    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
                    opts.desc = "Extract Variable"
                    vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, opts)
                    opts.desc = "Extract Constant"
                    vim.keymap.set("n", "<leader>ec", jdtls.extract_constant, opts)
                    opts.desc = "Extract Method"
                    vim.keymap.set("v", "<leader>em", function() jdtls.extract_method(true) end, opts)
                    opts.desc = "Test Class"
                    vim.keymap.set("n", "<leader>jt", jdtls.test_class, opts)
                    opts.desc = "Test Nearest Method"
                    vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, opts)
                end,
            }

            jdtls.start_or_attach(config)
        end

        -- Autocmd to attach jdtls on Java filetype
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = setup_jdtls,
        })

        -- Trigger immediately if current buffer is java
        if vim.bo.filetype == "java" then
            setup_jdtls()
        end
    end,
}
