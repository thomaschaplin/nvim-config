return {
  "stevearc/dressing.nvim",
  lazy = true,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
  config = function()
    require("dressing").setup({
      input = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = true,

        -- Default prompt string
        default_prompt = "Input",

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Can be 'left', 'right', or 'center'
        title_pos = "left",

        -- When true, <Esc> will close the modal
        insert_only = true,

        -- When true, input will start in insert mode.
        start_in_insert = true,

        -- These are passed to nvim_open_win
        border = "rounded",
        -- 'editor' and 'cursor' will default the `relative` option to that value
        relative = "cursor",

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        buf_options = {},
        win_options = {
          -- Disable line wrapping
          wrap = false,
          -- Indicator for when text exceeds window
          list = true,
          listchars = "precedes:…,extends:…",
          -- Increase this for more context
          sidescrolloff = 0,
        },

        -- Set to `false` to disable
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.ui.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = require('telescope.themes').get_dropdown({
          layout_config = {
            width = 0.8,
            height = 0.8,
          },
          borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        }),

        -- Options for fzf selector
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },

        -- Options for fzf-lua
        fzf_lua = {
          -- winopts = {
          --   height = 0.5,
          --   width = 0.5,
          -- },
        },

        -- Options for nui Menu
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 0,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },

        -- Options for built-in selector
        builtin = {
          -- Display numbers for options and set up keymaps
          show_numbers = true,
          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'cursor' will default the `relative` option to that value
          relative = "editor",

          buf_options = {},
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
          },

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- the min_ and max_ options can be a list of mixed types.
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },

          -- Set to `false` to disable
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return {
              backend = "telescope",
              telescope = require('telescope.themes').get_cursor({
                layout_config = {
                  width = 0.3,
                  height = 0.4,
                },
              }),
            }
          end
          
          if opts.kind == "legendary.nvim" then
            return {
              backend = "telescope",
              telescope = require('telescope.themes').get_dropdown({
                layout_config = {
                  width = 0.8,
                  height = 0.8,
                },
              }),
            }
          end

          -- For LSP references, definitions, etc.
          if opts.kind == "lsp" then
            return {
              backend = "telescope",
              telescope = require('telescope.themes').get_ivy({
                layout_config = {
                  height = 0.3,
                },
              }),
            }
          end

          -- Default config for other selectors
          return {}
        end,
      },
    })

    -- Custom highlights for dressing components
    local function set_dressing_highlights()
      -- Input highlights
      vim.api.nvim_set_hl(0, "DressingInputNormalFloat", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "DressingInputFloatBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "DressingInputFloatTitle", { 
        fg = "#89b4fa", -- Catppuccin blue
        bold = true 
      })

      -- Select highlights
      vim.api.nvim_set_hl(0, "DressingSelectNormalFloat", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "DressingSelectFloatBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "DressingSelectIdx", { 
        fg = "#fab387", -- Catppuccin peach
        bold = true 
      })
    end

    -- Set highlights after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_dressing_highlights,
      group = vim.api.nvim_create_augroup("DressingHighlights", { clear = true }),
    })

    -- Set initial highlights
    set_dressing_highlights()

    -- Enhanced user commands for debugging and testing
    vim.api.nvim_create_user_command("DressingTestInput", function()
      vim.ui.input({ 
        prompt = "Enter something: ",
        default = "test input",
      }, function(input)
        if input then
          vim.notify("You entered: " .. input, vim.log.levels.INFO)
        else
          vim.notify("Input cancelled", vim.log.levels.WARN)
        end
      end)
    end, { desc = "Test dressing input component" })

    vim.api.nvim_create_user_command("DressingTestSelect", function()
      vim.ui.select(
        { "Option 1", "Option 2", "Option 3", "Cancel" },
        {
          prompt = "Choose an option:",
          format_item = function(item)
            return "» " .. item
          end,
        },
        function(choice)
          if choice then
            vim.notify("You selected: " .. choice, vim.log.levels.INFO)
          else
            vim.notify("Selection cancelled", vim.log.levels.WARN)
          end
        end
      )
    end, { desc = "Test dressing select component" })

    -- Auto-command to provide visual feedback when dressing is used
    vim.api.nvim_create_autocmd("User", {
      pattern = "DressingInputOpen",
      callback = function()
        vim.notify("📝 Input dialog opened", vim.log.levels.DEBUG, { 
          title = "Dressing",
          timeout = 1000,
        })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "DressingSelectOpen", 
      callback = function()
        vim.notify("📋 Selection dialog opened", vim.log.levels.DEBUG, {
          title = "Dressing", 
          timeout = 1000,
        })
      end,
    })
  end,
}
