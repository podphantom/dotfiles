local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "Source current config/file" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below keeping cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search match (centered)" })

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left (keep selection)" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right (keep selection)" })

-- paste over selection without loosing yanked
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without replacing register" })

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
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Escape to Normal mode" })
-- format built in
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer with LSP" })

-- Replace the word cursor is on globally
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)
-- Executes shell command from in here making file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- tab / buffer stuff
vim.keymap.set("n", "<leader>to", "<cmd>enew<CR>", { desc = "Open new buffer" })
vim.keymap.set("n", "<leader>tx", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>tn", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>tp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to prev buffer" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

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
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		vim.notify("No active LSP clients to restart", vim.log.levels.WARN)
		return
	end
	local ok, err = pcall(function()
		vim.cmd("LspRestart")
	end)
	if ok then
		vim.notify("LSP restarted", vim.log.levels.INFO)
	else
		vim.notify("LSP restart failed: " .. tostring(err), vim.log.levels.ERROR)
	end
end, { desc = "Restart LSP" })

vim.keymap.set("n", "<leader>jr", function()
	vim.cmd("terminal javac % && java %:t:r")
end, { desc = "Compile & Run Java" })

-- Compile & Run C / C++
vim.keymap.set("n", "<leader>cr", function()
	local ft = vim.bo.filetype
	if ft == "cpp" then
		vim.cmd("split | terminal g++ -std=c++17 -Wall -Wextra % -o %:r && ./%:r")
	elseif ft == "c" then
		vim.cmd("split | terminal gcc -Wall -Wextra % -o %:r && ./%:r")
	else
		vim.notify("Not a C or C++ file", vim.log.levels.WARN)
	end
end, { desc = "Compile & Run C/C++" })

-- Compile C / C++ with debug symbols (-g) for DAP
vim.keymap.set("n", "<leader>cb", function()
	local ft = vim.bo.filetype
	if ft == "cpp" then
		vim.cmd("split | terminal g++ -std=c++17 -g -Wall -Wextra % -o %:r")
	elseif ft == "c" then
		vim.cmd("split | terminal gcc -g -Wall -Wextra % -o %:r")
	else
		vim.notify("Not a C or C++ file", vim.log.levels.WARN)
	end
end, { desc = "Compile C/C++ with Debug symbols" })

--Breakpoint 
-- vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
-- vim.keymap.set("n", "<leader>bc", dap.continue, { desc = "Continue / Start Debug" })
-- vim.keymap.set("n", "<leader>bs", dap.step_over, { desc = "Step Over" })
-- vim.keymap.set("n", "<leader>bi", dap.step_into, { desc = "Step Into" })
-- vim.keymap.set("n", "<leader>bo", dap.step_out, { desc = "Step Out" })
-- vim.keymap.set("n", "<leader>br", dap.restart, { desc = "Restart Debug" })
-- vim.keymap.set("n", "<leader>bq", dap.terminate, { desc = "Quit Debug" })
