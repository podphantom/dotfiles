return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "neovim/nvim-lspconfig",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Add Conditional Breakpoint" },
        { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Add Log Point" },
        { "<leader>dc", function()
            local dap = require("dap")
            if vim.bo.filetype == "java" then
                local ok, jdtls_dap = pcall(require, "jdtls.dap")
                if ok then
                    jdtls_dap.setup_dap_main_class_configs({
                        on_ready = function()
                            dap.continue()
                        end,
                    })
                    return
                end
            end
            dap.continue()
        end, desc = "Start / Continue Debugging" },
        { "<leader>ds", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dr", function() require("dap").restart() end, desc = "Restart Debugger" },
        { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate Debugger" },
        { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI layout" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval variable under cursor" },
        { "<leader>df", function() require("dapui").float_element("scopes", { enter = true }) end, desc = "Float DAP Scopes window" },
        { "<leader>dfb", function() require("dapui").float_element("breakpoints", { enter = true }) end, desc = "Float DAP Breakpoints window" },
        { "<leader>dft", function() require("dapui").float_element("stacks", { enter = true }) end, desc = "Float DAP Stacks window" },
        { "<leader>dfw", function() require("dapui").float_element("watches", { enter = true }) end, desc = "Float DAP Watches window" },
        { "<leader>dfr", function() require("dapui").float_element("repl", { enter = true }) end, desc = "Float DAP REPL window" },
        { "<leader>dfc", function() require("dapui").float_element("console", { enter = true }) end, desc = "Float DAP Console window" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local virtual_text = require("nvim-dap-virtual-text")

        -- Setup Enlarged DAP UI (Wider sidebar & bigger Scopes pane)
        dapui.setup({
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.55 },      -- 55% of sidebar height allocated to Scopes
                        { id = "breakpoints", size = 0.15 },
                        { id = "stacks", size = 0.15 },
                        { id = "watches", size = 0.15 },
                    },
                    position = "left",
                    size = 55, -- Enlarged sidebar width (55 columns wide)
                },
                {
                    elements = {
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                    position = "bottom",
                    size = 14,
                },
            },
            floating = {
                max_height = 0.85,
                max_width = 0.85,
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
        })

        -- Virtual Text Debugger (EOL position with ■ icon matching LSP diagnostic style)
        virtual_text.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            clear_on_continue = false,
            display_callback = function(variable, _buf, _stackframe, _node, _options)
                return "  ■ " .. variable.name .. " = " .. variable.value
            end,
            virt_text_pos = "eol", -- End-Of-Line position like LSP diagnostic virtual text
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })

        -- Distinct Highlight Groups for Debugger Virtual Text & Line Execution Flow
        vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#e0af68", italic = true, bold = true })
        vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", { fg = "#ff9e64", italic = true, bold = true })
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f7768e", bold = true })
        vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e0af68", bold = true })
        vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#9ece6a", bold = true })
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2d3f66", bold = true })
        vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#565f89" })

        -- Automatically open/close DAP UI on debug sessions
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Clamping out-of-range lines when stepping out of main()
        local orig_focus_frame = dap.focus_frame
        dap.focus_frame = function(frame, ...)
            if frame and frame.source and frame.source.path and frame.line then
                local bufnr = vim.uri_to_bufnr(vim.uri_from_fname(frame.source.path))
                if vim.api.nvim_buf_is_valid(bufnr) then
                    local line_count = vim.api.nvim_buf_line_count(bufnr)
                    if frame.line > line_count then
                        frame.line = math.max(1, line_count)
                    end
                end
            end
            return pcall(orig_focus_frame, frame, ...)
        end

        -- Custom Breakpoint & Execution Flow Signs
        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "⚡", texthl = "DapBreakpointCondition", linehl = "", numhl = "DapBreakpointCondition" })
        vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" })
        vim.fn.sign_define("DapStopped", { text = "👉", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStopped" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "DapBreakpointRejected", linehl = "", numhl = "DapBreakpointRejected" })

        -- Default Java Debug Configurations Fallback
        dap.configurations.java = {
            {
                type = "java",
                request = "launch",
                name = "Debug (Launch) - Current File",
                mainClass = "${file}",
                projectName = "${workspaceFolder}",
            },
        }

        -- Configure codelldb adapter for C/C++ if installed in Mason
        local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
        local codelldb_path = mason_path .. "/codelldb/extension/adapter/codelldb"
        if vim.fn.executable(codelldb_path) == 1 then
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = codelldb_path,
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp
        end
    end,
}
