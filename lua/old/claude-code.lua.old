return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>ac", nil, desc = "AI/Claude Code" },
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>ccf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ccr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>ccc", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ccsm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>cca", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>ccs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>ccta",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    -- Diff management
    { "<leader>ccda", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ccdd ", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
