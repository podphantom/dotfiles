return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- ===== Setup DAP UI (theo docs chính thức) =====
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.30 },
							{ id = "breakpoints", size = 0.20 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40, -- Chiều rộng sidebar
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.50 },
							{ id = "console", size = 0.50 },
						},
						size = 12, -- Chiều cao phần dưới
						position = "bottom",
					},
				},
			})

			-- Tự mở/đóng UI khi debug
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- ===== KEYMAPS =====
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", function()
				require("jdtls.dap").setup_dap_main_class_configs()
				dap.continue()
			end, { desc = "Start Java Debug" })
			vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debug" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Quit Debug" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
			-- ===== Custom màu cho DAP UI =====
			vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIType", { fg = "#c792ea" })
			vim.api.nvim_set_hl(0, "DapUIValue", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "DapUIVariable", { fg = "#eeffff" })
			vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = "#ffcb6b", bold = true })
			vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIThread", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = "#ffcb6b" })
			vim.api.nvim_set_hl(0, "DapUISource", { fg = "#c792ea" })
			vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = "#f07178" })
			vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = "#f07178" })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = "#c3e88d", bold = true })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUICurrentFrameName", { fg = "#c3e88d", bold = true })
			vim.api.nvim_set_hl(0, "DapUIStepOver", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIStepInto", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIStepBack", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIStepOut", { fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapUIStop", { fg = "#f07178" })
			vim.api.nvim_set_hl(0, "DapUIPlayPause", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "DapUIRestart", { fg = "#c3e88d" })
			vim.api.nvim_set_hl(0, "DapUIUnavailable", { fg = "#4a4a4a" })

			-- Màu breakpoint và dòng đang dừng
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#f07178" })
			vim.api.nvim_set_hl(0, "DapStopped", { bg = "#1c2a3a", fg = "#82aaff" })
			vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#1c2a3a" })

			-- Mở element dạng floating (tiện lợi)
			vim.keymap.set("n", "<leader>df", function()
				dapui.float_element(nil, { enter = true })
			end, { desc = "Float DAP Element" })
		end,
	},
}
