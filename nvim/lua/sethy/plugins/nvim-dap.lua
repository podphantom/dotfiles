return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            local function safe_update_render()
                pcall(function()
                    dapui.update_render({})
                end)
            end

            -- ===== Inline Virtual Text (VSCode-style with background pill) =====
            require("nvim-dap-virtual-text").setup({
                enabled                     = true,
                enabled_commands            = true,   -- :DapVirtualTextEnable / Disable / Toggle
                highlight_changed_variables = true,   -- highlight vars whose value changed
                highlight_new_as_changed    = true,   -- treat newly appeared vars like changed
                show_stop_reason            = true,   -- show reason why execution stopped
                commented                  = false,   -- prefix with comment chars
                only_first_definition      = true,    -- show only on first occurrence per scope
                all_references             = false,
                filter_references_pattern  = "<module",
                -- Virtual text appearance
                virt_text_pos   = "eol",              -- end-of-line
                all_frames      = false,              -- only current frame
                virt_lines      = false,
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value
                    else
                        return " 󰨰 " .. variable.name .. " = " .. variable.value .. " "
                    end
                end,
            })

            -- Distinct background pill highlights for debugger virtual text
            vim.api.nvim_set_hl(0, "NvimDapVirtualText",        { bg = "#203046", fg = "#7FB4CA", italic = true, bold = true })
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", { bg = "#3D2A1D", fg = "#FF9F43", italic = true, bold = true })
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextError",   { bg = "#3B1E1E", fg = "#E86671", italic = true, bold = true })
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextInfo",    { bg = "#1E3B27", fg = "#98C379", italic = true, bold = true })

            -- ===== Breakpoint Signs (Red) =====
            vim.fn.sign_define("DapBreakpoint", {
                text = "●",
                texthl = "DapBreakpointSign",
                linehl = "DapBreakpointLine",
                numhl = "DapBreakpointNum",
            })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = "◆",
                texthl = "DapBreakpointConditionSign",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = "○",
                texthl = "DapBreakpointRejectedSign",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapLogPoint", {
                text = "◎",
                texthl = "DapLogPointSign",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapStopped", {
                text = "▶",
                texthl = "DapStoppedSign",
                linehl = "DapStoppedLine",
                numhl = "DapStoppedNum",
            })

            -- ===== Highlight groups =====
            vim.api.nvim_set_hl(0, "DapBreakpointSign",          { fg = "#F44747", bold = true })
            vim.api.nvim_set_hl(0, "DapBreakpointLine",          { bg = "#3a1a1a" })
            vim.api.nvim_set_hl(0, "DapBreakpointNum",           { fg = "#F44747" })
            vim.api.nvim_set_hl(0, "DapBreakpointConditionSign", { fg = "#FF9F43", bold = true })
            vim.api.nvim_set_hl(0, "DapBreakpointRejectedSign",  { fg = "#6C6C6C" })
            vim.api.nvim_set_hl(0, "DapLogPointSign",            { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "DapStoppedSign",             { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "DapStoppedLine",             { bg = "#1e2d1e" })
            vim.api.nvim_set_hl(0, "DapStoppedNum",              { fg = "#98C379" })

            -- ===== DAP UI highlights =====
            vim.api.nvim_set_hl(0, "DapUIScope",                 { fg = "#61AFEF", bg = "#22354E", bold = true })
            vim.api.nvim_set_hl(0, "DapUIIndent",                { fg = "#61AFEF", bg = "#22354E" })
            vim.api.nvim_set_hl(0, "DapUIType",                  { fg = "#C678DD", italic = true })
            vim.api.nvim_set_hl(0, "DapUIDecoration",            { fg = "#61AFEF", bold = true })
            vim.api.nvim_set_hl(0, "DapUIThread",                { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "DapUIStoppedThread",         { fg = "#FF9F43", bold = true })
            vim.api.nvim_set_hl(0, "DapUISource",                { fg = "#C792EA" })
            vim.api.nvim_set_hl(0, "DapUILineNumber",            { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIFloatBorder",           { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "DapUIVariable",              { fg = "#E5C07B", bold = true })
            vim.api.nvim_set_hl(0, "DapUIValue",                 { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "DapUIModifiedValue",         { fg = "#FF9F43", bg = "#3B2A1D", bold = true })
            vim.api.nvim_set_hl(0, "DapUICursorLine",            { bg = "#2C3E5B", bold = true })
            vim.api.nvim_set_hl(0, "DapUIWatchesEmpty",          { fg = "#F44747", italic = true })
            vim.api.nvim_set_hl(0, "DapUIWatchesValue",          { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "DapUIWatchesError",          { fg = "#F44747" })
            vim.api.nvim_set_hl(0, "DapUIBreakpointsPath",       { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo",       { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine",{ fg = "#FF9F43", bold = true })
            vim.api.nvim_set_hl(0, "DapUIBreakpointsLine",       { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUICurrentFrameName",      { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "DapUIStepOver",              { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIStepInto",              { fg = "#C792EA" })
            vim.api.nvim_set_hl(0, "DapUIStepBack",              { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIStepOut",               { fg = "#FF9F43" })
            vim.api.nvim_set_hl(0, "DapUIStop",                  { fg = "#F44747", bold = true })
            vim.api.nvim_set_hl(0, "DapUIPlayPause",             { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "DapUIRestart",               { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "DapUIUnavailable",           { fg = "#4A4A4A" })
            vim.api.nvim_set_hl(0, "DapUIEndofBuffer",           { fg = "#2C2C2C" })

            -- ===== Per-panel WinBar colour strips =====
            -- Each panel gets its own accent colour on the WinBar title
            -- and a very faint tinted Normal background

            -- Scopes  → cyan/blue
            vim.api.nvim_set_hl(0, "DapUIScopesWinBar",
                { fg = "#FFFFFF", bg = "#1D4A77", bold = true })
            vim.api.nvim_set_hl(0, "DapUIScopesNormal",
                { bg = "#142130" })

            -- Breakpoints  → red
            vim.api.nvim_set_hl(0, "DapUIBreakpointsWinBar",
                { fg = "#FFFFFF", bg = "#5C1A1A", bold = true })
            vim.api.nvim_set_hl(0, "DapUIBreakpointsNormal",
                { bg = "#2A0D0D" })

            -- Stacks  → purple
            vim.api.nvim_set_hl(0, "DapUIStacksWinBar",
                { fg = "#FFFFFF", bg = "#3A1A5C", bold = true })
            vim.api.nvim_set_hl(0, "DapUIStacksNormal",
                { bg = "#1E0D30" })

            -- Watches  → green
            vim.api.nvim_set_hl(0, "DapUIWatchesWinBar",
                { fg = "#FFFFFF", bg = "#1A4A2A", bold = true })
            vim.api.nvim_set_hl(0, "DapUIWatchesNormal",
                { bg = "#0D2215" })

            -- REPL  → orange
            vim.api.nvim_set_hl(0, "DapUIReplWinBar",
                { fg = "#FFFFFF", bg = "#5C3A1A", bold = true })
            vim.api.nvim_set_hl(0, "DapUIReplNormal",
                { bg = "#2A1A0D" })

            -- Console  → teal
            vim.api.nvim_set_hl(0, "DapUIConsoleWinBar",
                { fg = "#FFFFFF", bg = "#1A4A4A", bold = true })
            vim.api.nvim_set_hl(0, "DapUIConsoleNormal",
                { bg = "#0D2222" })

            -- Apply via FileType autocmd (fires whenever dap-ui opens a panel or floating window)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "dapui_scopes", "dapui_breakpoints",
                    "dapui_stacks", "dapui_watches",
                    "dap-repl",     "dapui_console", "dapui_hover",
                },
                callback = function(ev)
                    local ft = vim.bo[ev.buf].filetype
                    local map = {
                        dapui_scopes      = "DapUIScopes",
                        dapui_breakpoints = "DapUIBreakpoints",
                        dapui_stacks      = "DapUIStacks",
                        dapui_watches     = "DapUIWatches",
                        ["dap-repl"]      = "DapUIRepl",
                        dapui_console     = "DapUIConsole",
                    }
                    local prefix = map[ft]
                    if prefix then
                        -- Tint the panel background + colour the WinBar title strip
                        vim.wo.winhighlight = table.concat({
                            "Normal:"    .. prefix .. "Normal",
                            "WinBar:"    .. prefix .. "WinBar",
                            "WinBarNC:"  .. prefix .. "WinBar",
                            "EndOfBuffer:" .. "DapUIEndofBuffer",
                        }, ",")
                    end

                    vim.wo.signcolumn   = "yes:1"
                    vim.wo.number       = false
                    vim.wo.cursorline   = true

                    -- Enable stepping keymaps directly inside DAP UI & Floating windows
                    local bopts = { buffer = ev.buf, silent = true }
                    vim.keymap.set("n", "<leader>ds", function() dap.step_over(); safe_update_render() end, vim.tbl_extend("force", { desc = "Step Over" }, bopts))
                    vim.keymap.set("n", "<leader>di", function() dap.step_into(); safe_update_render() end, vim.tbl_extend("force", { desc = "Step Into" }, bopts))
                    vim.keymap.set("n", "<leader>do", function() dap.step_out(); safe_update_render() end, vim.tbl_extend("force", { desc = "Step Out" }, bopts))
                    vim.keymap.set("n", "<leader>dc", function() dap.continue(); safe_update_render() end, vim.tbl_extend("force", { desc = "Start / Continue Debug" }, bopts))
                    vim.keymap.set("n", "<leader>dr", function() dap.restart(); safe_update_render() end, vim.tbl_extend("force", { desc = "Restart Debug" }, bopts))
                    vim.keymap.set("n", "<leader>dq", function() dap.terminate(); safe_update_render() end, vim.tbl_extend("force", { desc = "Quit Debug" }, bopts))

                    -- Auto-update Scopes & DAP UI immediately when submitting input in REPL
                    if ft == "dap-repl" then
                        vim.keymap.set({ "n", "i" }, "<CR>", function()
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
                            vim.defer_fn(function()
                                safe_update_render()
                            end, 150)
                        end, bopts)
                    end
                end,
            })

            -- ===== DAP UI Layout =====
            dapui.setup({
                icons = {
                    expanded  = "▾",
                    collapsed = "▸",
                    current_frame = "→",
                },
                mappings = {
                    edit = "e",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    repl = "r",
                    toggle = "t",
                },
                element_mappings = {},
                expand_lines = true,
                force_buffers = true,
                layouts = {
                    -- LEFT sidebar: scopes + breakpoints + stacks + watches
                    {
                        elements = {
                            { id = "scopes",      size = 0.50 },
                            { id = "breakpoints", size = 0.15 },
                            { id = "stacks",      size = 0.20 },
                            { id = "watches",     size = 0.15 },
                        },
                        size     = 55,
                        position = "left",
                    },
                    -- BOTTOM bar: repl + console
                    {
                        elements = {
                            { id = "repl",    size = 0.45 },
                            { id = "console", size = 0.55 },
                        },
                        size     = 10,
                        position = "bottom",
                    },
                },
                controls = {
                    enabled = true,
                    element = "repl",
                    icons = {
                        pause        = " ",
                        play         = " ",
                        step_into    = " ",
                        step_over    = " ",
                        step_out     = " ",
                        step_back    = " ",
                        run_last     = "↺ ",
                        terminate    = "□ ",
                        disconnect   = "⏏ ",
                    },
                },
                floating = {
                    max_height  = 0.9,
                    max_width   = 0.7,
                    border      = "rounded",
                    mappings    = { close = { "q", "<Esc>" } },
                },
                windows = { indent = 1 },
                render  = {
                    max_type_length = nil,
                    max_value_lines = 100,
                    indent          = 1,
                },
            })

            -- ===== Auto open/close UI & Restore Code Buffer =====
            local last_code_buf = nil
            local last_code_win = nil

            dap.listeners.after.event_initialized["dapui_config"] = function()
                last_code_win = vim.api.nvim_get_current_win()
                last_code_buf = vim.api.nvim_get_current_buf()
                dapui.open()
            end
            dap.listeners.after.event_stopped["dapui_auto_update"] = function()
                safe_update_render()
            end

            local function cleanup_dap()
                dapui.close()
                if last_code_win and vim.api.nvim_win_is_valid(last_code_win) then
                    vim.api.nvim_set_current_win(last_code_win)
                end
                if last_code_buf and vim.api.nvim_buf_is_valid(last_code_buf) then
                    vim.api.nvim_set_current_buf(last_code_buf)
                end
            end

            dap.listeners.before.event_terminated["dapui_config"] = cleanup_dap
            dap.listeners.before.event_exited["dapui_config"] = cleanup_dap

            -- ===== C / C++ Adapter (codelldb) =====
            local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
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
                    name = "Launch binary (codelldb)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local file = vim.fn.expand("%:p")
                        local outfile = vim.fn.expand("%:p:r")

                        if file ~= "" then
                            local ft = vim.bo.filetype
                            local compiler = (ft == "c") and "gcc" or "g++ -std=c++17"
                            local cmd = string.format("%s -g %s -o %s", compiler, vim.fn.shellescape(file), vim.fn.shellescape(outfile))
                            vim.fn.system(cmd)
                            if vim.fn.executable(outfile) == 1 then
                                return outfile
                            end
                        end

                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp

            -- ===== Keymaps =====
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,  { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dl", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "Log Point" })

            vim.keymap.set("n", "<leader>dc", function()
                if vim.bo.filetype == "java" then
                    pcall(require("jdtls.dap").setup_dap_main_class_configs)
                end
                dap.continue()
            end, { desc = "Start / Continue Debug" })

            vim.keymap.set("n", "<leader>ds", dap.step_over,  { desc = "Step Over" })
            vim.keymap.set("n", "<leader>di", dap.step_into,  { desc = "Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_out,   { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dr", dap.restart,    { desc = "Restart Debug" })
            vim.keymap.set("n", "<leader>dq", dap.terminate,  { desc = "Quit Debug" })
            vim.keymap.set("n", "<leader>du", dapui.toggle,   { desc = "Toggle DAP UI" })
            vim.keymap.set({ "n", "v" }, "<leader>de", function()
                dapui.eval()
            end, { desc = "Eval variable under cursor in popup float" })
            -- Floating DAP Windows
            vim.keymap.set("n", "<leader>df", function()
                dapui.float_element("scopes", { enter = true })
            end, { desc = "Float DAP Scopes" })
            vim.keymap.set("n", "<leader>dfs", function()
                dapui.float_element("scopes", { enter = true })
            end, { desc = "Float DAP Scopes" })
            vim.keymap.set("n", "<leader>dfb", function()
                dapui.float_element("breakpoints", { enter = true })
            end, { desc = "Float DAP Breakpoints" })
            vim.keymap.set("n", "<leader>dft", function()
                dapui.float_element("stacks", { enter = true })
            end, { desc = "Float DAP Stacks" })
            vim.keymap.set("n", "<leader>dfw", function()
                dapui.float_element("watches", { enter = true })
            end, { desc = "Float DAP Watches" })
            vim.keymap.set("n", "<leader>dfr", function()
                dapui.float_element("repl", { enter = true })
            end, { desc = "Float DAP REPL" })
            vim.keymap.set("n", "<leader>dfc", function()
                dapui.float_element("console", { enter = true })
            end, { desc = "Float DAP Console / Terminal" })
        end,
    },
}
