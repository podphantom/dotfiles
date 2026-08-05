return {
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewFileHistory",
        },
        keys = {
            -- Open diff against HEAD (current changes)
            { "<leader>gd",  "<cmd>DiffviewOpen<cr>",              desc = "Diffview: open diff (HEAD)" },
            -- Open diff for a specific branch/commit (prompts)
            { "<leader>gD",  "<cmd>DiffviewOpen HEAD~1<cr>",        desc = "Diffview: diff vs HEAD~1" },
            -- File history for current file
            { "<leader>ghf", "<cmd>DiffviewFileHistory %<cr>",     desc = "Diffview: file history" },
            -- Full repo history
            { "<leader>ghr", "<cmd>DiffviewFileHistory<cr>",       desc = "Diffview: repo history" },
            -- Close
            { "<leader>gdc", "<cmd>DiffviewClose<cr>",             desc = "Diffview: close" },
        },
        config = function()
            local actions = require("diffview.actions")

            require("diffview").setup({
                diff_binaries    = false,
                enhanced_diff_hl = true,       -- extra highlights inside changed lines
                use_icons        = true,
                show_help_hints  = true,
                watch_index      = true,

                icons = {
                    folder_closed = "",
                    folder_open   = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open   = "",
                    done        = "✓",
                },

                view = {
                    -- Default 2-panel side-by-side diff
                    default = {
                        layout             = "diff2_horizontal",
                        disable_diagnostics = true,
                        winbar_info        = false,
                    },
                    -- Merge conflicts: 3 panels (ours | base | theirs) + result below
                    merge_tool = {
                        layout              = "diff3_horizontal",
                        disable_diagnostics = true,
                        winbar_info         = true,
                    },
                    -- File history view
                    file_history = {
                        layout              = "diff2_horizontal",
                        disable_diagnostics = true,
                        winbar_info         = false,
                    },
                },

                file_panel = {
                    listing_style     = "tree",   -- "list" | "tree"
                    tree_options = {
                        flatten_dirs    = true,
                        folder_statuses = "only_folded",
                    },
                    win_config = {
                        position = "left",
                        width    = 35,
                        win_opts = {},
                    },
                },

                file_history_panel = {
                    log_options = {
                        git = {
                            single_file = {
                                diff_merges = "combined",
                            },
                            multi_file = {
                                diff_merges = "first-parent",
                            },
                        },
                    },
                    win_config = {
                        position = "bottom",
                        height   = 16,
                        win_opts = {},
                    },
                },

                commit_log_panel = {
                    win_config = { win_opts = {} },
                },

                default_args = {
                    DiffviewOpen         = {},
                    DiffviewFileHistory  = {},
                },

                hooks = {},

                keymaps = {
                    disable_defaults = false,
                    view = {
                        { "n", "<leader>gdc", actions.close,                   { desc = "Close Diffview" } },
                        { "n", "<tab>",       actions.select_next_entry,        { desc = "Next changed file" } },
                        { "n", "<s-tab>",     actions.select_prev_entry,        { desc = "Prev changed file" } },
                        { "n", "gf",          actions.goto_file_edit,           { desc = "Open file in prev tab" } },
                        { "n", "<C-w>gf",     actions.goto_file_tab,            { desc = "Open file in new tab" } },
                        { "n", "<leader>e",   actions.focus_files,              { desc = "Focus file panel" } },
                        { "n", "<leader>b",   actions.toggle_files,             { desc = "Toggle file panel" } },
                        { "n", "g<C-x>",      actions.cycle_layout,             { desc = "Cycle diff layout" } },
                        { "n", "[x",          actions.prev_conflict,            { desc = "Prev conflict" } },
                        { "n", "]x",          actions.next_conflict,            { desc = "Next conflict" } },
                        -- Merge conflict resolution
                        { "n", "<leader>co",  actions.conflict_choose("ours"),   { desc = "Choose ours" } },
                        { "n", "<leader>ct",  actions.conflict_choose("theirs"), { desc = "Choose theirs" } },
                        { "n", "<leader>cb",  actions.conflict_choose("base"),   { desc = "Choose base" } },
                        { "n", "<leader>ca",  actions.conflict_choose("all"),    { desc = "Choose all" } },
                        { "n", "dx",          actions.conflict_choose("none"),   { desc = "Delete conflict" } },
                    },
                    diff1 = { { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Help" } } },
                    diff2 = { { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Help" } } },
                    diff3 = {
                        { { "n", "x" }, "2do", actions.diffget("ours"),   { desc = "Get from ours" } },
                        { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Get from theirs" } },
                        { "n", "g?", actions.help({ "view", "diff3" }), { desc = "Help" } },
                    },
                    diff4 = {
                        { { "n", "x" }, "1do", actions.diffget("base"),   { desc = "Get from base" } },
                        { { "n", "x" }, "2do", actions.diffget("ours"),   { desc = "Get from ours" } },
                        { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Get from theirs" } },
                        { "n", "g?", actions.help({ "view", "diff4" }), { desc = "Help" } },
                    },
                    file_panel = {
                        { "n", "j",          actions.next_entry,           { desc = "Next file" } },
                        { "n", "k",          actions.prev_entry,           { desc = "Prev file" } },
                        { "n", "<cr>",       actions.select_entry,         { desc = "Open diff" } },
                        { "n", "s",          actions.toggle_stage_entry,   { desc = "Stage/unstage" } },
                        { "n", "S",          actions.stage_all,            { desc = "Stage all" } },
                        { "n", "U",          actions.unstage_all,          { desc = "Unstage all" } },
                        { "n", "X",          actions.restore_entry,        { desc = "Restore file" } },
                        { "n", "R",          actions.refresh_files,        { desc = "Refresh" } },
                        { "n", "L",          actions.open_commit_log,      { desc = "Commit log" } },
                        { "n", "g?",         actions.help("file_panel"),   { desc = "Help" } },
                    },
                    file_history_panel = {
                        { "n", "g?",  actions.help("file_history_panel"), { desc = "Help" } },
                        { "n", "j",   actions.next_entry,                 { desc = "Next entry" } },
                        { "n", "k",   actions.prev_entry,                 { desc = "Prev entry" } },
                        { "n", "<cr>",actions.select_entry,               { desc = "Show diff" } },
                        { "n", "y",   actions.copy_hash,                  { desc = "Copy hash" } },
                        { "n", "L",   actions.open_commit_log,            { desc = "Commit details" } },
                    },
                },
            })
        end,
    },
}
