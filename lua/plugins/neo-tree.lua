return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          '.git',
          'node_modules'
        },
        hide_by_pattern = {
          "**/node_modules/*",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db"
        },
        always_show = {
          ".gitignored",
        }
      },
    }
  },
  config = function()
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>", {})
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
  end,
}
