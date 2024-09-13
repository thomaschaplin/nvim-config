return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      open_mapping = [[<c-j>]],
      autochdir = true,
    })
  end,
}
