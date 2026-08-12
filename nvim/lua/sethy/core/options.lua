vim.g.netrw_banner = 0

vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- search
vim.opt.inccommand = "split"

-- UI
vim.opt.scrolloff = 8
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes:1"

-- folding
vim.o.foldenable = true
vim.o.foldmethod = "manual"
vim.o.foldlevel = 99
vim.o.foldcolumn = "0"

-- window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- misc
vim.opt.guicursor = ""
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 250
vim.opt.colorcolumn = "0"
vim.opt.mouse = "a"
vim.opt.shortmess:append("I") -- Disable default Neovim intro splash message
-- Clipboard
vim.opt.clipboard = "unnamedplus"   -- Đồng bộ với clipboard hệ thống
vim.opt.clipboard:append("unnamed") -- Hỗ trợ thêm

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Highlight active window cursorline only (disabled during Insert mode for zero typing delay)
local cursorline_group = vim.api.nvim_create_augroup("ActiveCursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufEnter", "InsertLeave" }, {
    group = cursorline_group,
    callback = function()
        vim.opt_local.cursorline = true
    end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
    group = cursorline_group,
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

