return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    image = { enabled = true },
    lazygit = {
      enabled = true,
      win = {
        position = "float",
        width = 0.9,
        height = 0.9,
        backdrop = 60,
        border = "rounded",
        zindex = 50
      }
    },
    bufdelete = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        position = "bottom",
        height = 0.4,
      },
      bo = {
        filetype = "snacks_terminal",
      }
    },
  },
  keys = {
    { "<C-f>", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<C-b>", function() Snacks.explorer.open() end, desc = "Explorer" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<C-/>", function()
      local cwd = vim.fn.expand("%:p:h")
      Snacks.terminal.toggle(nil, { cwd = cwd })
    end, desc = "Toggle Terminal" }
  },
}
