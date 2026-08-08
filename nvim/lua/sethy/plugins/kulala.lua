return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		default_view = "body",
		winbar = true,
		icons = {
			inlay = {
				loading = "⏳",
				done = "✅",
				error = "❌",
			},
		},
	},
	keys = {
		{
			"<leader>Rr",
			function()
				require("kulala").run()
			end,
			desc = "Execute HTTP request",
		},
		{
			"<leader>Ra",
			function()
				require("kulala").run_all()
			end,
			desc = "Execute all HTTP requests",
		},
		{
			"<leader>Ri",
			function()
				require("kulala").inspect()
			end,
			desc = "Inspect HTTP request",
		},
		{
			"<leader>Rt",
			function()
				require("kulala").toggle_view()
			end,
			desc = "Toggle Headers/Body view",
		},
		{
			"<leader>Rp",
			function()
				require("kulala").jump_prev()
			end,
			desc = "Jump to previous request",
		},
		{
			"<leader>Rn",
			function()
				require("kulala").jump_next()
			end,
			desc = "Jump to next request",
		},
		{
			"<leader>Ry",
			function()
				require("kulala").copy()
			end,
			desc = "Copy request as cURL",
		},
		{
			"<leader>Re",
			function()
				require("kulala").set_selected_env()
			end,
			desc = "Select HTTP environment",
		},
	},
}
