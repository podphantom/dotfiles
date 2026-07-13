return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<leader>t]],
      direction = "float", -- popup nổi, giống ý bạn muốn
      float_opts = {
        border = "curved",
      },
      shading_factor = 2,
      size = 20,
    })
  end,
}
