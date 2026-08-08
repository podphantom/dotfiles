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

		-- Keymaps for Dropbar
		vim.keymap.set("n", "<leader>dp", dropbar_api.pick, { desc = "Dropbar: Pick breadcrumb" })
		vim.keymap.set("n", "<leader>dn", dropbar_api.select_next_context, { desc = "Dropbar: Select next context" })
	end,
}
