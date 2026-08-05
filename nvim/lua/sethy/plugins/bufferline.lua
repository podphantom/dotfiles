return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        keys = {
            { "<Tab>",        "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "<S-Tab>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<leader>tn",   "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "<leader>tp",   "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<leader>bx",   "<cmd>bdelete<cr>",             desc = "Close buffer" },
            { "<leader>bo",   "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
            { "<leader>bp",   "<cmd>BufferLineTogglePin<cr>",  desc = "Pin/unpin buffer" },
            { "<leader>b1",   "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
            { "<leader>b2",   "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
            { "<leader>b3",   "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
            { "<leader>b4",   "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
            { "<leader>b5",   "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
        },
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    mode            = "buffers",
                    style_preset    = bufferline.style_preset.default,
                    themable        = true,
                    numbers         = "none",
                    close_command   = "bdelete! %d",

                    -- Icons matching the classic bufferline UI style
                    buffer_close_icon        = "✕",
                    modified_icon            = "●",
                    close_icon               = "✕",
                    left_trunc_marker        = "",
                    right_trunc_marker       = "",

                    -- Indicator bar on active buffer
                    indicator = {
                        icon = "▎",
                        style = "icon",
                    },

                    -- Layout
                    max_name_length          = 18,
                    max_prefix_length        = 15,
                    truncate_names           = true,
                    tab_size                 = 18,
                    diagnostics              = "nvim_lsp",           -- show LSP error count on tab
                    diagnostics_update_in_insert = false,
                    diagnostics_indicator    = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    color_icons              = true,                 -- coloured filetype icons
                    show_buffer_icons        = true,
                    show_buffer_close_icons  = true,
                    show_close_icon          = true,                 -- top right close icon
                    show_tab_indicators      = true,
                    show_duplicate_prefix    = true,
                    persist_buffer_sort      = true,
                    move_wraps_at_ends       = false,
                    separator_style          = "thin",               -- thin vertical line separators (|) as shown in image
                    enforce_regular_tabs     = false,
                    always_show_bufferline   = true,
                    hover = {
                        enabled = true,
                        delay   = 150,
                        reveal  = { "close" },
                    },
                    -- Groups: pin group always left
                    groups = {
                        items = {
                            require("bufferline.groups").builtin.pinned:with({ icon = "📌" }),
                            require("bufferline.groups").builtin.ungrouped,
                        },
                    },
                    -- Sidebar offset so the bufferline clears oil/nvim-tree
                    offsets = {
                        {
                            filetype   = "oil",
                            text       = " File Explorer",
                            highlight  = "BufferLineOffsetSeparator",
                            separator  = true,
                            text_align = "left",
                        },
                    },
                },
                highlights = {
                    -- Active buffer tab (the buffer you are currently working on)
                    buffer_selected = {
                        fg = "#FFFFFF",
                        bg = "#2e3c64",
                        bold = true,
                        italic = false,
                    },
                    indicator_selected = {
                        fg = "#7dcfff",
                        bg = "#2e3c64",
                    },
                    duplicate_selected = {
                        fg = "#7dcfff",
                        bg = "#2e3c64",
                        bold = true,
                    },
                    close_button_selected = {
                        fg = "#f7768e",
                        bg = "#2e3c64",
                    },
                    modified_selected = {
                        fg = "#e0af68",
                        bg = "#2e3c64",
                    },
                    separator_selected = {
                        fg = "#1a1b26",
                        bg = "#2e3c64",
                    },

                    -- Inactive buffer tabs
                    background = {
                        fg = "#565f89",
                    },
                    buffer_visible = {
                        fg = "#787c99",
                        italic = true,
                    },
                    close_button = {
                        fg = "#565f89",
                    },
                    modified = {
                        fg = "#e0af68",
                    },
                },
            })
        end,
    },
}
