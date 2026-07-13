return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                check_ts = true,
                fast_wrap = {},
            })

            -- Tab nhảy ra ngoài ngoặc (cách đơn giản)
            vim.keymap.set("i", "<Tab>", function()
                local line = vim.fn.getline(".")
                local col = vim.fn.col(".") 

                local next_char = line:sub(col, col)

                -- Nếu ký tự tiếp theo là dấu đóng thì nhảy qua
                if next_char:match("[%\"'%)%]}>]") then
                    return "<Right>"
                end

                -- Nếu không thì dùng Tab bình thường (accept completion)
                return require("blink.cmp").accept()
            end, { expr = true, silent = true })
        end,
    },
}
