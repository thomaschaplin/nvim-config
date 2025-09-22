return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      flavour = "mocha",
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      }
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
