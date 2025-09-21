return {
  "rmagatti/auto-session",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("auto-session").setup({
      -- Enhanced session directory management
      auto_session_suppress_dirs = {
        "~/",
        "~/Projects",
        "~/Downloads",
        "/",
        "/tmp",
        "/Users",
        vim.fn.stdpath("config"), -- Don't auto-save sessions in config dir
        vim.fn.stdpath("data"),   -- Don't auto-save sessions in data dir
      },

      -- Better session naming and management
      auto_session_use_git_branch = true, -- Include git branch in session name
      auto_session_create_enabled = true, -- Auto-create sessions
      auto_session_enabled = true, -- Enable auto-session
      auto_restore_enabled = true, -- Auto-restore last session
      auto_save_enabled = true, -- Auto-save sessions

      -- Enhanced session lens configuration
      session_lens = {
        buftypes_to_ignore = { "help", "nofile", "terminal", "prompt" },
        load_on_setup = true,
        theme_conf = {
          winblend = 10,
          border = true,
          layout_strategy = "center",
          layout_config = {
            width = 0.8,
            height = 0.6,
            preview_cutoff = 120,
          },
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        previewer = true,
        prompt_title = "Sessions",
        results_title = "Available Sessions",
        selection_caret = "➤ ",
      },

      -- Hooks for better integration
      pre_save_cmds = {
        "Neotree close",      -- Close file explorer before saving
        "cclose",             -- Close quickfix
        "lclose",             -- Close location list
        "TroubleClose",       -- Close trouble if available
        "ToggleTerm 1 close", -- Close toggleterm
        "silent! %bd|e#",     -- Close all buffers except current
      },

      post_restore_cmds = {
        "silent! bufdo e", -- Refresh all buffers
      },

      -- Save/restore extra session data
      save_extra_cmds = {
        "echo &columns . ',' . &lines", -- Save terminal dimensions
      },

      -- Better file handling
      bypass_session_save_file_types = {
        "alpha",
        "dashboard",
        "NvimTree",
        "neo-tree",
        "TelescopePrompt",
        "lazy",
        "mason",
        "help",
      },
    })

    -- Enhanced keymaps
    local keymap = vim.keymap.set
    keymap("n", "<leader>ss", "<cmd>AutoSession save<CR>", { desc = "Save session" })
    keymap("n", "<leader>sr", "<cmd>AutoSession restore<CR>", { desc = "Restore session" })
    keymap("n", "<leader>sd", "<cmd>AutoSession delete<CR>", { desc = "Delete session" })
    keymap("n", "<leader>sf", "<cmd>AutoSession search<CR>", { desc = "Find session" })
    keymap("n", "<C-r>", "<cmd>AutoSession search<CR>", { desc = "Search sessions" })

    -- Auto-commands for better session management
    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup("AutoSession", { clear = true })

    -- Disable auto-save for certain file types
    autocmd("FileType", {
      pattern = { "alpha", "dashboard", "lazy", "mason", "TelescopePrompt" },
      callback = function()
        vim.b.auto_session_enabled = false
      end,
      group = augroup,
    })

    -- Better session restoration notifications
    autocmd("User", {
      pattern = "AutoSessionRestorePre",
      callback = function(data)
        local session_name = data.data.session_name or "default"
        vim.notify("🔄 Restoring session: " .. session_name, vim.log.levels.INFO, {
          title = "Session Manager",
        })
      end,
      group = augroup,
    })

    autocmd("User", {
      pattern = "AutoSessionRestorePost",
      callback = function(data)
        local session_name = data.data.session_name or "default"
        vim.notify("✅ Session restored: " .. session_name, vim.log.levels.INFO, {
          title = "Session Manager",
        })
      end,
      group = augroup,
    })

    autocmd("User", {
      pattern = "AutoSessionSavePost",
      callback = function()
        vim.notify("💾 Session saved", vim.log.levels.INFO, {
          title = "Session Manager",
        })
      end,
      group = augroup,
    })

    -- Auto-save session before exiting
    autocmd("VimLeavePre", {
      callback = function()
        if not vim.g.auto_session_enabled then
          return
        end
        -- Only save if we have actual files open
        local buffers = vim.api.nvim_list_bufs()
        local has_files = false
        for _, buf in ipairs(buffers) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
            local name = vim.api.nvim_buf_get_name(buf)
            if name ~= "" and not name:match("^term://") then
              has_files = true
              break
            end
          end
        end
        if has_files then
          vim.cmd("AutoSession save")
        end
      end,
      group = augroup,
    })

    -- Session status in statusline (if you want)
    vim.g.session_status = function()
      local session_name = require("auto-session").current_session_name()
      if session_name then
        return "📁 " .. vim.fn.fnamemodify(session_name, ":t:r")
      end
      return ""
    end
  end,
}
