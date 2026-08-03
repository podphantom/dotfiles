local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- paste over selection without loosing yanked
vim.keymap.set("x", "p", [["_dP]])

-- ===== DELETE & CUT CUSTOM =====

-- d, dd, dw... →  Delete without yanking
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, desc = "Delete without yank" })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, desc = "Delete line without yank" })
vim.keymap.set("n", "dw", '"_dw', { noremap = true, desc = "Delete word without yank" })
vim.keymap.set("n", "diw", '"_diw', { noremap = true, desc = "Delete inner word without yank" })
vim.keymap.set("n", "daw", '"_daw', { noremap = true, desc = "Delete a word without yank" })
-- x → Delete without yanking
vim.keymap.set({ "n", "v" }, "x", '"+d', { noremap = true, desc = "Cut (like Ctrl+X)" })
vim.keymap.set("n", "X", '"+D', { noremap = true, desc = "Cut to end of line" })

vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
-- format built in
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Replace the word cursor is on globally
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)
-- Executes shell command from in here making file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

--split management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- restart
vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", {
	desc = "Restart Neovim (:restart)",
})

vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("lsp restart")
	vim.notify("LSP restarted", vim.log.levels.INFO)
end, { desc = "Restart LSP" })

vim.keymap.set("n", "<leader>jr", function()
	vim.cmd("terminal javac % && java %:t:r")
end, { desc = "Compile & Run Java" })

--Breakpoint 
-- vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
-- vim.keymap.set("n", "<leader>bc", dap.continue, { desc = "Continue / Start Debug" })
-- vim.keymap.set("n", "<leader>bs", dap.step_over, { desc = "Step Over" })
-- vim.keymap.set("n", "<leader>bi", dap.step_into, { desc = "Step Into" })
-- vim.keymap.set("n", "<leader>bo", dap.step_out, { desc = "Step Out" })
-- vim.keymap.set("n", "<leader>br", dap.restart, { desc = "Restart Debug" })
-- vim.keymap.set("n", "<leader>bq", dap.terminate, { desc = "Quit Debug" })
