return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- only start session saving when a actual file was opened
    opts = {
        dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
        need = 1, -- minimum number of buffers that need to be open to save
        branch = true, -- use git branch to save separate sessions per branch
    },
    keys = {
        { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session (CWD)" },
        { "<leader>qS", function() require("persistence").select() end, desc = "Select Session" },
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
}
