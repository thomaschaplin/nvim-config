return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    lazygit = { enabled = true },
  },
  keys = {
    {
      "<leader>lg",
      function()
        Snacks.lazygit.open()
      end,
      desc = "LazyGit",
    },
    {
      "<leader>lglf",
      function()
        Snacks.lazygit.log_file()
      end,
    },
    {
      "<leader>lgl",
      function()
        Snacks.lazygit.log()
      end,
    },
  },
}
