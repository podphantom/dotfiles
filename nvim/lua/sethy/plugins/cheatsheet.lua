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
            { lhs = "<C-h>", desc = "Navigate to left window split / tmux pane" },
            { lhs = "<C-j>", desc = "Navigate to lower window split / tmux pane" },
            { lhs = "<C-k>", desc = "Navigate to upper window split / tmux pane" },
            { lhs = "<C-l>", desc = "Navigate to right window split / tmux pane" },
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
        category = "🔍 Search & Pickers (Snacks / Telescope)",
        items = {
            { lhs = "<leader>pws", desc = "Search word / visual selection", action = function() require("snacks").picker.grep_word() end },
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
        category = "🌿 Git Integration",
        items = {
            { lhs = "<leader>lg", desc = "Open LazyGit terminal popup", action = function() require("snacks").lazygit() end },
            { lhs = "<leader>gl", desc = "View LazyGit logs", action = function() require("snacks").lazygit.log() end },
            { lhs = "<leader>gg", desc = "Fugitive fullscreen tab", action = "<cmd>tabnew | Git | only<CR>" },
            { lhs = "<leader>gbr", desc = "Pick and switch Git branches", action = function() require("snacks").picker.git_branches() end },
            { lhs = "<leader>p", desc = "Git push" },
            { lhs = "<leader>P", desc = "Git pull" },
        },
    },
    {
        category = "⚡ Movement & Editing Habits",
        items = {
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
            width = 0.65,
            height = 0.75,
        },
        format = function(item)
            local cat = item.category or ""
            local lhs = item.lhs or ""
            local desc = item.desc or ""
            return {
                { string.format("%-34s", cat), "SnacksPickerTitle" },
                { string.format("%-18s", lhs), "SnacksPickerKeymapLhs" },
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
