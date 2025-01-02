return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.git_files, {})
      vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
      vim.keymap.set("n", "<leader>gcm", builtin.git_commits, {})
      require("telescope").load_extension("ui-select")
    end,
  },
}
