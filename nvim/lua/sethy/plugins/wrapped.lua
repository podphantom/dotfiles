return {
    "aikhe/wrapped.nvim",
    dependencies = { "nvzone/volt" },
    cmd = { "WrappedNvim", "NvimWrapped" },
    keys = {
        { "<leader>wr", function() require("wrapped").run() end, desc = "Wrapped Neovim Heatmap & Stats" },
    },
    opts = {
        path = vim.fn.stdpath("config"),
    },
}
