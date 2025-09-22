return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      custom_highlights = function(colors)
        return {
          -- Snacks picker
          SnacksPickerNormal = { bg = colors.mantle },
          SnacksPickerBorder = { bg = colors.mantle, fg = colors.blue },
          SnacksPickerSelection = { bg = colors.surface0, fg = colors.text },
        }
      end,
      integrations = {
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            warnings = { "italic" },
          },
        },
        snacks = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
