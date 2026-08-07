return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    opts = {
        enabled = true,
        max_time = 1000,
        max_count = 2,
        disable_mouse = true,
        hint = true,
        notification = true,
        allow_different_key = false,
        disabled_filetypes = {
            "NvimTree",
            "TelescopePrompt",
            "oil",
            "lazy",
            "mason",
            "trouble",
            "dashboard",
            "snacks_picker_input",
            "snacks_dashboard",
            "snacks_layout",
            "diffview",
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_watches",
            "dap-repl",
            "qf",
            "help",
            "minifiles",
            "minifiles-help",
            "hardtime",
        },
        disabled_keys = {
            ["<Up>"] = { "n", "i", "v" },
            ["<Down>"] = { "n", "i", "v" },
            ["<Left>"] = { "n", "i", "v" },
            ["<Right>"] = { "n", "i", "v" },
        },
        hints = {
            -- Scroll / Vertical navigation hints
            ["[jk]%d+[jk]"] = {
                message = function()
                    return "Tip: Use <C-d>/<C-u> to scroll half-page, or Harpoon (<C-y>, <C-i>, <C-n>, <C-s>)"
                end,
            },
            -- Word motion hints
            ["[wb]%d+[wb]"] = {
                message = function()
                    return "Tip: Use f/t motions, n/N search (centered), or <leader>pws (Snacks grep word)"
                end,
            },
            -- Line movement in visual mode
            [":m"] = {
                message = function()
                    return "Tip: Select lines in Visual mode and press J or K to move them down or up"
                end,
            },
            -- Delete without yank vs Cut
            ["\"_d"] = {
                message = function()
                    return "Tip: 'd' deletes without yanking ('_d). Use 'x' / 'X' to cut to clipboard ('+d)."
                end,
            },
            -- Command line buffer cycling
            [":bnext"] = {
                message = function()
                    return "Tip: Use <leader>tn to go to next buffer, <leader>tp for prev buffer"
                end,
            },
            [":bprev"] = {
                message = function()
                    return "Tip: Use <leader>tp to go to prev buffer, <leader>tn for next buffer"
                end,
            },
            [":bdelete"] = {
                message = function()
                    return "Tip: Use <leader>tx or <leader>dB to close current buffer"
                end,
            },
            -- Command line splits
            [":vsplit"] = {
                message = function()
                    return "Tip: Use <leader>sv to split window vertically, <leader>sh horizontally"
                end,
            },
            [":split"] = {
                message = function()
                    return "Tip: Use <leader>sh to split window horizontally, <leader>sv vertically"
                end,
            },
            -- Explorer
            [":Ex"] = {
                message = function()
                    return "Tip: Press '-' for Oil explorer, <leader>ee for MiniFiles, or <leader>ex for NvimTree"
                end,
            },
        },
    },
    keys = {
        { "<leader>ht", "<cmd>Hardtime toggle<CR>", desc = "Toggle Hardtime" },
        { "<leader>hr", "<cmd>Hardtime report<CR>", desc = "Report Hardtime stats" },
    },
}
