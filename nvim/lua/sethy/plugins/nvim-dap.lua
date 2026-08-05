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

            -- ===== Inline Virtual Text (VSCode-style) =====
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
                virt_text_pos   = "eol",              -- end-of-line (like VSCode)
                all_frames      = false,              -- only current frame
                virt_lines      = false,
                virt_text_win_col = nil,
            })

            -- Highlight groups for virtual text
            vim.api.nvim_set_hl(0, "NvimDapVirtualText",        { fg = "#7C8FAD", italic = true })
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", { fg = "#FF9F43", italic = true, bold = true })
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextError",   { fg = "#F44747", italic = true })
            vim.api.nvim_set_hl(0, "NvimDapVirtualTextInfo",    { fg = "#61AFEF", italic = true })

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
            vim.api.nvim_set_hl(0, "DapUIScope",                 { fg = "#82AAFF", bold = true })
            vim.api.nvim_set_hl(0, "DapUIType",                  { fg = "#C792EA" })
            vim.api.nvim_set_hl(0, "DapUIDecoration",            { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIThread",                { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "DapUIStoppedThread",         { fg = "#FF9F43", bold = true })
            vim.api.nvim_set_hl(0, "DapUISource",                { fg = "#C792EA" })
            vim.api.nvim_set_hl(0, "DapUILineNumber",            { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIFloatBorder",           { fg = "#82AAFF" })
            vim.api.nvim_set_hl(0, "DapUIVariable",              { fg = "#EEFFFF" })
            vim.api.nvim_set_hl(0, "DapUIValue",                 { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "DapUIModifiedValue",         { fg = "#FF9F43", bold = true, italic = true })
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
                { fg = "#FFFFFF", bg = "#1A3A5C", bold = true })
            vim.api.nvim_set_hl(0, "DapUIScopesNormal",
                { bg = "#0D1F30" })

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

            -- Apply via FileType autocmd (fires whenever dap-ui opens a panel)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "dapui_scopes", "dapui_breakpoints",
                    "dapui_stacks", "dapui_watches",
                    "dap-repl",     "dapui_console",
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
                    if not prefix then return end

                    -- Tint the panel background + colour the WinBar title strip
                    vim.wo.winhighlight = table.concat({
                        "Normal:"    .. prefix .. "Normal",
                        "WinBar:"    .. prefix .. "WinBar",
                        "WinBarNC:"  .. prefix .. "WinBar",
                        "EndOfBuffer:" .. "DapUIEndofBuffer",
                    }, ",")

                    -- Soft left-border using a coloured SignColumn
                    vim.wo.signcolumn   = "yes:1"
                    vim.wo.number       = false
                    vim.wo.cursorline   = true
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
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open   = "o",
                    remove = "d",
                    edit   = "e",
                    repl   = "r",
                    toggle = "t",
                },
                element_mappings = {},
                expand_lines = true,
                force_buffers = true,
                layouts = {
                    -- LEFT sidebar: scopes + breakpoints + stacks + watches
                    {
                        elements = {
                            { id = "scopes",      size = 0.40 },
                            { id = "breakpoints", size = 0.20 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.15 },
                        },
                        size     = 42,
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
                    max_width   = 0.5,
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

            -- ===== Auto open/close UI =====
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- ===== Keymaps =====
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,  { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dl", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "Log Point" })

            vim.keymap.set("n", "<leader>dc", function()
                require("jdtls.dap").setup_dap_main_class_configs()
                dap.continue()
            end, { desc = "Start / Continue Debug" })

            vim.keymap.set("n", "<leader>ds", dap.step_over,  { desc = "Step Over" })
            vim.keymap.set("n", "<leader>di", dap.step_into,  { desc = "Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_out,   { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dr", dap.restart,    { desc = "Restart Debug" })
            vim.keymap.set("n", "<leader>dq", dap.terminate,  { desc = "Quit Debug" })
            vim.keymap.set("n", "<leader>du", dapui.toggle,   { desc = "Toggle DAP UI" })
            vim.keymap.set("n", "<leader>df", function()
                dapui.float_element(nil, { enter = true })
            end, { desc = "Float DAP Element" })
        end,
    },
}
