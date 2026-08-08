return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			opts = {
				log_level = "TRACE",
			},
			adapters = {
				http = {
					openrouter = function()
						return require("codecompanion.adapters").extend("openrouter", {
							env = {
								api_key = "OPENROUTER_API_KEY",
							},
							opts = {
								stream = true,
							},
							schema = {
								model = {
									default = "openrouter/free",
									choices = {
										"openrouter/free",
										"google/gemma-4-31b-it:free",
										"openai/gpt-oss-20b:free",
										"cohere/north-mini-code:free",
									},
								},
								include_reasoning = {
									default = false,
									mapping = "parameters",
								},
								max_tokens = {
									default = 4000,
									mapping = "parameters",
								},
							},
						})
					end,
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "ANTHROPIC_API_KEY",
							},
						})
					end,
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							env = {
								api_key = "OPENAI_API_KEY",
							},
						})
					end,
					deepseek = function()
						return require("codecompanion.adapters").extend("deepseek", {
							env = {
								api_key = "DEEPSEEK_API_KEY",
							},
						})
					end,
					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							env = {
								api_key = "GEMINI_API_KEY",
							},
						})
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "openrouter",
				},
				inline = {
					adapter = "openrouter",
				},
				agent = {
					adapter = "openrouter",
				},
				cmd = {
					adapter = "openrouter",
				},
			},
			interactions = {
				chat = {
					adapter = "openrouter",
					keymaps = {
						send = {
							modes = {
								n = { "<CR>", "<C-s>" },
								i = { "<C-s>", "<CR>" },
							},
						},
					},
				},
				inline = {
					adapter = "openrouter",
				},
				background = {
					adapter = "openrouter",
					chat = {
						opts = {
							enabled = false,
						},
					},
				},
			},
			display = {
				chat = {
					show_settings = true,
					show_token_count = true,
					render_headers = true,
					window = {
						layout = "vertical",
						width = 0.40,
					},
				},
				diff = {
					provider = "default",
				},
			},
		})

		-- Safe toggle function to prevent Vim(hide):E444: Cannot close last window
		local function safe_toggle_chat()
			local wins = vim.api.nvim_list_wins()
			if #wins == 1 and vim.bo.filetype == "codecompanion" then
				vim.cmd("enew")
			end
			vim.cmd("CodeCompanionChat Toggle")
		end

		-- Keybindings
		local map = vim.keymap.set
		map({ "n", "v" }, "<leader>ac", safe_toggle_chat, { desc = "Toggle CodeCompanion Chat" })
		map({ "n", "v" }, "<leader>as", "<cmd>CodeCompanionChat Send<CR>", { desc = "Send CodeCompanion Chat" })
		map({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion Inline Prompt" })
		map({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion Action Palette" })
		map({ "n", "v" }, "<leader>aq", "<cmd>CodeCompanionCmd<CR>", { desc = "CodeCompanion CLI Command" })
		map("v", "<leader>aC", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add selection to CodeCompanion Chat" })
	end,
}
