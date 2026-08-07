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

            -- Smart Tab: Step over closing quotes/brackets, or completion / snippet
            vim.keymap.set("i", "<Tab>", function()
                local line = vim.fn.getline(".")
                local col = vim.fn.col(".")
                local next_char = line:sub(col, col)

                -- 1. If next character is a closing quote, bracket, or punctuation, step right
                if next_char:match("[%\"'%)%]}>;,]") then
                    return "<Right>"
                end

                -- 2. If completion menu is open, select next item
                local ok, cmp = pcall(require, "blink.cmp")
                if ok and cmp.is_visible() then
                    cmp.select_next()
                    return ""
                end

                -- 3. If inside a snippet, jump to next snippet placeholder
                if ok and cmp.snippet_active() then
                    cmp.snippet_forward()
                    return ""
                end

                -- 4. Otherwise insert literal Tab
                return "<Tab>"
            end, { expr = true, silent = true, desc = "Smart Tab step out / completion / snippet" })
        end,
    },
}
