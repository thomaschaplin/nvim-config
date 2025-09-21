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
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      -- Custom trayio project picker function
      local function trayio_project_picker()
        local projects_path = vim.fn.expand("~/GIT/trayio")
        local projects = vim.fn.systemlist("find " .. projects_path .. " -maxdepth 1 -type d -name '*' | grep -v '^" .. projects_path .. "$'")

        -- Ensure sessions exist for all trayio projects
        for _, project_path in ipairs(projects) do
          local session_name = project_path:gsub("/", "_"):gsub("^_", "")
          local session_file = vim.fn.stdpath("data") .. "/sessions/" .. session_name .. ".vim"

          -- Create a basic session if it doesn't exist
          if vim.fn.filereadable(session_file) == 0 then
            local current_dir = vim.fn.getcwd()
            vim.cmd("cd " .. project_path)
            vim.cmd("AutoSession save")
            vim.cmd("cd " .. current_dir)
          end
        end

        -- Use AutoSession's built-in search but filter to trayio projects
        vim.cmd("AutoSession search")
      end

      vim.keymap.set("n", "<C-p>", function()
        local git_files = builtin.git_files
        local find_files = builtin.find_files
        local ok = pcall(git_files, { show_untracked = true })
        if not ok then
          find_files()
        end
      end, {})
      vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
      vim.keymap.set("n", "<C-r>", trayio_project_picker, { desc = "Open Trayio project picker" })
      require("telescope").load_extension("ui-select")
    end,
  },
}
