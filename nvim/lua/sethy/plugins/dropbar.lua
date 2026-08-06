return {
	"Bekaboo/dropbar.nvim",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		bar = {
			enable = function(buf, win)
				return vim.api.nvim_buf_is_valid(buf)
					and vim.api.nvim_win_is_valid(win)
					and vim.wo[win].number
					and vim.bo[buf].buftype == ""
					and vim.bo[buf].filetype ~= ""
					and not vim.wo[win].diff
			end,
		},
	},
	config = function(_, opts)
		local dropbar = require("dropbar")
		local dropbar_api = require("dropbar.api")

		dropbar.setup(opts)

		-- Background highlight for winbar / dropbar
		local function set_dropbar_hl()
			vim.api.nvim_set_hl(0, "WinBar", { bg = "#1e2030" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#161622" })
		end
		set_dropbar_hl()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = set_dropbar_hl,
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>dp", dropbar_api.pick, { desc = "Dropbar: Pick breadcrumb" })
	--	vim.keymap.set("n", "<leader>ds", dropbar_api.goto_context_start, { desc = "Dropbar: Go to context start" })
		vim.keymap.set("n", "<leader>dn", dropbar_api.select_next_context, { desc = "Dropbar: Select next context" })
	end,
}
