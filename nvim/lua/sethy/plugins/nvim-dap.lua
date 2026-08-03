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

			-- Setup DAP UI
			dapui.setup()

			-- Tự mở/đóng UI khi debug
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Java adapter (nếu cần)
			-- dap.adapters.java = function(callback)
			-- 	callback({ type = "server", host = "127.0.0.1", port = 5005 })
			-- end
			-- Java configurations
			-- dap.configurations.java = {
			-- 	{
			-- 		type = "java",
			-- 		request = "launch",
			-- 		name = "Launch Current File",
			-- 		mainClass = function()
			-- 			return vim.fn.input("Main class: ", "", "file")
			-- 		end,
			-- 		projectName = function()
			-- 			return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			-- 		end,
			-- 	},
			-- 	{
			-- 		type = "java",
			-- 		request = "attach",
			-- 		name = "Attach to Process",
			-- 		hostName = "127.0.0.1",
			-- 		port = 5005,
			-- 	},
			-- }
			dap.configurations.java = {
				{
					type = "java",
					request = "launch",
					name = "Launch Current File",
					mainClass = "",
					projectName = "",
				},
			}
			-- ===== KEYMAPS =====
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
    require("jdtls.dap").setup_dap_main_class_configs()
    require("dap").continue()
end, { desc = "Start Java Debug" })
			vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debug" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Quit Debug" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
}
