return {
    "gisketch/triforce.nvim",
    dependencies = { "nvzone/volt" },
    event = "VeryLazy",
    keys = {
        { "<leader>tg", function() require("triforce").show_profile() end, desc = "Triforce RPG Profile UI" },
    },
    opts = {
        enabled = true,
        gamification_enabled = true,
        notifications = {
            enabled = true,
            level_up = true,
            achievements = true,
        },
    },
}
