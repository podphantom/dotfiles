local cheatsheet_data = {
    {
        category = "📂 File Management & Explorers",
        items = {
            { lhs = "-", desc = "Open parent directory in Oil", action = "<CMD>Oil<CR>" },
            { lhs = "<leader>-", desc = "Open Oil in floating window", action = function() require("oil").toggle_float() end },
            { lhs = "<leader>ee", desc = "Toggle MiniFiles explorer", action = "<cmd>lua MiniFiles.open()<CR>" },
            { lhs = "<leader>ex", desc = "Toggle NvimTree file explorer", action = "<cmd>NvimTreeToggle<CR>" },
            { lhs = "<leader>eX", desc = "Find current file in NvimTree", action = "<cmd>NvimTreeFindFileToggle<CR>" },
            { lhs = "<leader>ec", desc = "Collapse NvimTree explorer", action = "<cmd>NvimTreeCollapse<CR>" },
            { lhs = "<leader>er", desc = "Refresh NvimTree explorer", action = "<cmd>NvimTreeRefresh<CR>" },
            { lhs = "<leader>rN", desc = "Fast rename current file", action = function() require("snacks").rename.rename_file() end },
            { lhs = "<leader>fp", desc = "Copy relative file path to clipboard", action = function()
                local filePath = vim.fn.expand("%:~")
                vim.fn.setreg("+", filePath)
                vim.notify("File path copied: " .. filePath, vim.log.levels.INFO)
            end },
            { lhs = "<leader>X", desc = "Make current file executable (chmod +x)", action = "<cmd>!chmod +x %<CR>" },
        },
    },
    {
        category = "📑 Buffer & Tab Management",
        items = {
            { lhs = "<leader>tn", desc = "Cycle to Next buffer", action = "<cmd>BufferLineCycleNext<CR>" },
            { lhs = "<leader>tp", desc = "Cycle to Previous buffer", action = "<cmd>BufferLineCyclePrev<CR>" },
            { lhs = "<leader>to", desc = "Open new empty buffer", action = "<cmd>enew<CR>" },
            { lhs = "<leader>tx", desc = "Close active buffer", action = "<cmd>bdelete<CR>" },
            { lhs = "<leader>dB", desc = "Confirm and delete buffer", action = function() require("snacks").bufdelete() end },
            { lhs = "<leader>tf", desc = "Open current buffer in new tab", action = "<cmd>tabnew %<CR>" },
        },
    },
    {
        category = "🪟 Window Splits & Navigation",
        items = {
            { lhs = "<leader>sv", desc = "Split window Vertically", action = "<C-w>v" },
            { lhs = "<leader>sh", desc = "Split window Horizontally", action = "<C-w>s" },
            { lhs = "<leader>se", desc = "Equalize split window sizes", action = "<C-w>=" },
            { lhs = "<leader>sx", desc = "Close current split window", action = "<cmd>close<CR>" },
            { lhs = "<leader>mx", desc = "Maximize / minimize split window", action = "<cmd>MaximizerToggle<CR>" },
            { lhs = "<C-h>", desc = "Navigate to left window split / tmux pane" },
            { lhs = "<C-j>", desc = "Navigate to lower window split / tmux pane" },
            { lhs = "<C-k>", desc = "Navigate to upper window split / tmux pane" },
            { lhs = "<C-l>", desc = "Navigate to right window split / tmux pane" },
            { lhs = "<prefix> ?", desc = "Open interactive Tmux Cheatsheet popup" },
        },
    },
    {
        category = "🎯 Harpoon Jumps & Quick Marks",
        items = {
            { lhs = "<leader>a", desc = "Add current file to Harpoon", action = function() require("harpoon"):list():add() end },
            { lhs = "<C-e>", desc = "Toggle Harpoon quick menu", action = function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end },
            { lhs = "<C-y>", desc = "Jump to Harpoon file 1", action = function() require("harpoon"):list():select(1) end },
            { lhs = "<C-i>", desc = "Jump to Harpoon file 2", action = function() require("harpoon"):list():select(2) end },
            { lhs = "<C-n>", desc = "Jump to Harpoon file 3", action = function() require("harpoon"):list():select(3) end },
            { lhs = "<C-s>", desc = "Jump to Harpoon file 4", action = function() require("harpoon"):list():select(4) end },
            { lhs = "<C-S-P>", desc = "Go to previous Harpoon buffer", action = function() require("harpoon"):list():prev() end },
            { lhs = "<C-S-N>", desc = "Go to next Harpoon buffer", action = function() require("harpoon"):list():next() end },
        },
    },
    {
        category = "🔍 Search & Pickers (FFF / Snacks / Telescope)",
        items = {
            { lhs = "<leader>pf", desc = "Open fast FFF file picker", action = function() require("fff").find_files() end },
            { lhs = "<leader>ps", desc = "Live fuzzy grep word in workspace (FFF)", action = function() require("fff").live_grep() end },
            { lhs = "<leader>pgf", desc = "Find files in git root (FFF)", action = function() require("fff").find_in_git_root() end },
            { lhs = "<leader>pcf", desc = "Find files in Neovim config directory", action = function() require("fff").find_files_in_dir("~/.config/nvim") end },
            { lhs = "<leader>pws", desc = "Search word under cursor / visual selection", action = function() require("snacks").picker.grep_word() end },
            { lhs = "<leader>pk", desc = "Search all keymaps picker", action = function() require("snacks").picker.keymaps() end },
            { lhs = "<leader>pr", desc = "Recent files picker (Telescope)", action = "<cmd>Telescope oldfiles<CR>" },
            { lhs = "<leader>th", desc = "Pick colorschemes", action = function() require("snacks").picker.colorschemes() end },
            { lhs = "<leader>pt", desc = "Search all TODO comments", action = function() require("snacks").picker.todo_comments() end },
            { lhs = "<leader>vh", desc = "Search Neovim help pages", action = function() require("snacks").picker.help() end },
        },
    },
    {
        category = "🛠️ LSP & Code Intelligence",
        items = {
            { lhs = "<leader>f", desc = "Format buffer with LSP", action = function() vim.lsp.buf.format() end },
            { lhs = "<leader>s", desc = "Substitute word under cursor globally" },
            { lhs = "gd", desc = "Go to LSP Definition", action = "<cmd>Telescope lsp_definitions<CR>" },
            { lhs = "gD", desc = "Go to LSP Declaration", action = function() vim.lsp.buf.declaration() end },
            { lhs = "gR", desc = "Show LSP References", action = "<cmd>Telescope lsp_references<CR>" },
            { lhs = "gi", desc = "Show LSP Implementations", action = "<cmd>Telescope lsp_implementations<CR>" },
            { lhs = "gt", desc = "Show LSP Type definitions", action = "<cmd>Telescope lsp_type_definitions<CR>" },
            { lhs = "K", desc = "Show hover documentation", action = function() vim.lsp.buf.hover() end },
            { lhs = "<leader>rn", desc = "Rename symbol with LSP", action = function() vim.lsp.buf.rename() end },
            { lhs = "<leader>vca", desc = "See available code actions", action = function() vim.lsp.buf.code_action() end },
            { lhs = "<leader>D", desc = "Show buffer diagnostics", action = function() require("snacks").picker.diagnostics_buffer() end },
            { lhs = "df", desc = "Show line diagnostic float window", action = function() vim.diagnostic.open_float() end },
            { lhs = "<leader>lx", desc = "Toggle LSP virtual text" },
        },
    },
    {
        category = "⚠️ Diagnostics & Quickfix (Trouble)",
        items = {
            { lhs = "<leader>xw", desc = "Open workspace diagnostics list", action = "<cmd>Trouble diagnostics toggle<CR>" },
            { lhs = "<leader>xd", desc = "Open document diagnostics list", action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>" },
            { lhs = "<leader>xq", desc = "Open quickfix list in Trouble", action = "<cmd>Trouble quickfix toggle<CR>" },
            { lhs = "<leader>xl", desc = "Open location list in Trouble", action = "<cmd>Trouble loclist toggle<CR>" },
            { lhs = "<leader>xt", desc = "Open TODO items in Trouble", action = "<cmd>Trouble todo toggle<CR>" },
        },
    },
    {
        category = "🐞 Debugging (DAP & DAP UI)",
        items = {
            { lhs = "<leader>db", desc = "Toggle Breakpoint", action = function() require("dap").toggle_breakpoint() end },
            { lhs = "<leader>dB", desc = "Add Conditional Breakpoint" },
            { lhs = "<leader>dl", desc = "Add Log Point" },
            { lhs = "<leader>dc", desc = "Start / Continue Debugging", action = function() require("dap").continue() end },
            { lhs = "<leader>ds", desc = "Step Over", action = function() require("dap").step_over() end },
            { lhs = "<leader>di", desc = "Step Into", action = function() require("dap").step_into() end },
            { lhs = "<leader>do", desc = "Step Out", action = function() require("dap").step_out() end },
            { lhs = "<leader>dr", desc = "Restart Debugger", action = function() require("dap").restart() end },
            { lhs = "<leader>dq", desc = "Terminate Debugger", action = function() require("dap").terminate() end },
            { lhs = "<leader>du", desc = "Toggle DAP UI layout", action = function() require("dapui").toggle() end },
            { lhs = "<leader>de", desc = "Eval variable under cursor", action = function() require("dapui").eval() end },
            { lhs = "<leader>df", desc = "Float DAP Scopes window", action = function() require("dapui").float_element("scopes", { enter = true }) end },
            { lhs = "<leader>dfb", desc = "Float DAP Breakpoints window", action = function() require("dapui").float_element("breakpoints", { enter = true }) end },
            { lhs = "<leader>dft", desc = "Float DAP Stacks window", action = function() require("dapui").float_element("stacks", { enter = true }) end },
            { lhs = "<leader>dfw", desc = "Float DAP Watches window", action = function() require("dapui").float_element("watches", { enter = true }) end },
            { lhs = "<leader>dfr", desc = "Float DAP REPL window", action = function() require("dapui").float_element("repl", { enter = true }) end },
            { lhs = "<leader>dfc", desc = "Float DAP Console window", action = function() require("dapui").float_element("console", { enter = true }) end },
        },
    },
    {
        category = "🌿 Git Integration & Diffview",
        items = {
            { lhs = "<leader>lg", desc = "Open LazyGit terminal popup", action = function() require("snacks").lazygit() end },
            { lhs = "<leader>gl", desc = "View LazyGit logs", action = function() require("snacks").lazygit.log() end },
            { lhs = "<leader>gg", desc = "Fugitive fullscreen tab", action = "<cmd>tabnew | Git | only<CR>" },
            { lhs = "<leader>gbr", desc = "Pick and switch Git branches", action = function() require("snacks").picker.git_branches() end },
            { lhs = "<leader>gd", desc = "Open side-by-side Diffview (vs HEAD)", action = "<cmd>DiffviewOpen<CR>" },
            { lhs = "<leader>gD", desc = "Open Diffview vs HEAD~1", action = "<cmd>DiffviewOpen HEAD~1<CR>" },
            { lhs = "<leader>ghf", desc = "View file Git history diffs", action = "<cmd>DiffviewFileHistory %<CR>" },
            { lhs = "<leader>ghr", desc = "View repo Git history diffs", action = "<cmd>DiffviewFileHistory<CR>" },
            { lhs = "<leader>gdc", desc = "Close Diffview window", action = "<cmd>DiffviewClose<CR>" },
            { lhs = "]h / [h", desc = "Jump to Next / Previous Git Hunk" },
            { lhs = "<leader>gs", desc = "Stage current Git hunk" },
            { lhs = "<leader>gr", desc = "Reset current Git hunk" },
            { lhs = "<leader>gS", desc = "Stage whole buffer" },
            { lhs = "<leader>gR", desc = "Reset whole buffer" },
            { lhs = "<leader>gp", desc = "Preview Git hunk float" },
            { lhs = "<leader>gB", desc = "Toggle current line Git blame" },
            { lhs = "<leader>wl", desc = "List & switch Git Worktrees", action = function() require("telescope").extensions.git_worktree.git_worktrees() end },
            { lhs = "<leader>wc", desc = "Create Git Worktree branch", action = function() require("telescope").extensions.git_worktree.create_git_worktree() end },
            { lhs = "<leader>p", desc = "Git push" },
            { lhs = "<leader>P", desc = "Git pull (--rebase)" },
        },
    },
    {
        category = "💾 Session Management (Persistence)",
        items = {
            { lhs = "<leader>qs", desc = "Restore Session for current directory", action = function() require("persistence").load() end },
            { lhs = "<leader>qS", desc = "Select Session picker", action = function() require("persistence").select() end },
            { lhs = "<leader>ql", desc = "Restore Last active Session", action = function() require("persistence").load({ last = true }) end },
            { lhs = "<leader>qd", desc = "Stop saving current session", action = function() require("persistence").stop() end },
        },
    },
    {
        category = "⚡ Movement & Editing Habits",
        items = {
            { lhs = "s", desc = "Flash Teleport Jump to any label on screen", action = function() require("flash").jump() end },
            { lhs = "S", desc = "Flash Treesitter Scope Selection", action = function() require("flash").treesitter() end },
            { lhs = "<C-d>", desc = "Move down half-page (centered)" },
            { lhs = "<C-u>", desc = "Move up half-page (centered)" },
            { lhs = "n / N", desc = "Next / Previous search match (centered)" },
            { lhs = "jj", desc = "Escape to Normal mode (Insert mode)" },
            { lhs = "J / K", desc = "Move selected lines down / up (Visual mode)" },
            { lhs = "J", desc = "Join line below keeping cursor position" },
            { lhs = "< / >", desc = "Indent left / right without losing selection" },
            { lhs = "p", desc = "Paste over selection without yanking ('_dP)" },
            { lhs = "d / dd / dw", desc = "Delete without yanking to register ('_d)" },
            { lhs = "x / X", desc = "Cut character / line to system clipboard ('+d)" },
            { lhs = "<C-c>", desc = "Clear search highlight (:nohl)" },
        },
    },
    {
        category = "🛡️ Helper Tools & Config",
        items = {
            { lhs = "<leader>?", desc = "Open this Categorized Cheatsheet" },
            { lhs = "<leader>cs", desc = "Open Categorized Cheatsheet Picker" },
            { lhs = "<leader><leader>", desc = "Source current config/file (:so)", action = "<cmd>so<CR>" },
            { lhs = "<leader>wr", desc = "Wrapped Neovim Heatmap & Stats", action = function() require("wrapped").run() end },
            { lhs = "<leader>tg", desc = "Triforce RPG Profile UI", action = function() require("triforce").show_profile() end },
            { lhs = "<leader>ht", desc = "Toggle Hardtime ON/OFF", action = "<cmd>Hardtime toggle<CR>" },
            { lhs = "<leader>hr", desc = "Report Hardtime habit stats", action = "<cmd>Hardtime report<CR>" },
            { lhs = "<leader>ks", desc = "Toggle Showkeys", action = "<cmd>ShowkeysToggle<CR>" },
            { lhs = "<leader>lr", desc = "Restart LSP server" },
            { lhs = "<leader>re", desc = "Restart Neovim (:restart)", action = "<cmd>restart<CR>" },
            { lhs = "<leader>cr", desc = "Compile & Run C/C++" },
            { lhs = "<leader>cb", desc = "Compile C/C++ with Debug symbols (-g)" },
            { lhs = "<leader>jr", desc = "Compile & Run Java file" },
        },
    },
    {
        category = "🤖 AI Assistant & CodeCompanion",
        items = {
            { lhs = "<leader>ac", desc = "Toggle CodeCompanion AI Chat window", action = "<cmd>CodeCompanionChat Toggle<CR>" },
            { lhs = "<leader>as", desc = "Send Chat prompt to AI", action = "<cmd>CodeCompanionChat Send<CR>" },
            { lhs = "<leader>ai", desc = "Open CodeCompanion Inline Prompt", action = "<cmd>CodeCompanion<CR>" },
            { lhs = "<leader>ap", desc = "Open CodeCompanion Action Palette", action = "<cmd>CodeCompanionActions<CR>" },
            { lhs = "<leader>aq", desc = "Execute CodeCompanion CLI Command", action = "<cmd>CodeCompanionCmd<CR>" },
            { lhs = "<leader>aC", desc = "Add visual selection to AI Chat", action = "<cmd>CodeCompanionChat Add<CR>" },
        },
    },
    {
        category = "🌐 HTTP REST Client (Kulala)",
        items = {
            { lhs = "<leader>Rr", desc = "Execute HTTP request under cursor", action = function() require("kulala").run() end },
            { lhs = "<leader>Ra", desc = "Execute all HTTP requests in file", action = function() require("kulala").run_all() end },
            { lhs = "<leader>Ri", desc = "Inspect HTTP request headers/body", action = function() require("kulala").inspect() end },
            { lhs = "<leader>Rt", desc = "Toggle Headers/Body view", action = function() require("kulala").toggle_view() end },
            { lhs = "<leader>Rp", desc = "Jump to previous HTTP request", action = function() require("kulala").jump_prev() end },
            { lhs = "<leader>Rn", desc = "Jump to next HTTP request", action = function() require("kulala").jump_next() end },
            { lhs = "<leader>Ry", desc = "Copy request as cURL command", action = function() require("kulala").copy() end },
            { lhs = "<leader>Re", desc = "Select HTTP environment", action = function() require("kulala").set_selected_env() end },
        },
    },
}

local function open_cheatsheet_picker()
    local picker_items = {}
    for _, cat in ipairs(cheatsheet_data) do
        for _, item in ipairs(cat.items) do
            table.insert(picker_items, {
                category = cat.category,
                lhs = item.lhs,
                desc = item.desc,
                action = item.action,
                text = cat.category .. " " .. item.lhs .. " " .. item.desc,
            })
        end
    end

    require("snacks").picker({
        title = " ⌨️  Neovim Categorized Cheatsheet ",
        items = picker_items,
        preview = false,
        layout = {
            preset = "select",
            width = 0.88,
            height = 0.82,
        },
        format = function(item)
            local cat = item.category or ""
            local lhs = item.lhs or ""
            local desc = item.desc or ""
            return {
                { string.format("%-32s", cat), "SnacksPickerTitle" },
                { string.format("%-15s", lhs), "SnacksPickerKeymapLhs" },
                { desc, "SnacksPickerComment" },
            }
        end,
        confirm = function(picker, item)
            picker:close()
            if item and item.action then
                if type(item.action) == "function" then
                    item.action()
                elseif type(item.action) == "string" then
                    vim.cmd(vim.api.nvim_replace_termcodes(item.action, true, false, true))
                end
            end
        end,
    })
end

return {
    "folke/snacks.nvim",
    opts = {},
    config = function()
        vim.api.nvim_create_user_command("Cheatsheet", open_cheatsheet_picker, { desc = "Open Categorized Cheatsheet" })
        vim.keymap.set("n", "<leader>cs", open_cheatsheet_picker, { desc = "Categorized Cheatsheet" })
        vim.keymap.set("n", "<leader>?", open_cheatsheet_picker, { desc = "Categorized Cheatsheet" })
    end,
}
