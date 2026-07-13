return -- Debug
{
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    config = function()
        local dap = require("dap")
        -- Cấu hình Java (nếu cần)
        dap.adapters.java = function(callback)
            -- JDTLS sẽ tự handle
            callback({ type = "server", host = "127.0.0.1", port = 5005 })
        end
    end
}

