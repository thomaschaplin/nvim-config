return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          -- Enhanced telescope highlights
          TelescopeNormal = { bg = colors.mantle },
          TelescopeBorder = { bg = colors.mantle, fg = colors.blue },
          TelescopePromptNormal = { bg = colors.surface0 },
          TelescopePromptBorder = { bg = colors.surface0, fg = colors.blue },
          TelescopePromptTitle = { bg = colors.blue, fg = colors.mantle },
          TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
          TelescopeResultsTitle = { bg = colors.lavender, fg = colors.mantle },
          TelescopeSelection = { bg = colors.surface0, fg = colors.text },
          TelescopeSelectionCaret = { fg = colors.flamingo },

          -- Enhanced barbar highlights
          BufferCurrent = { bg = colors.surface0, fg = colors.text },
          BufferCurrentIndex = { bg = colors.surface0, fg = colors.blue },
          BufferCurrentMod = { bg = colors.surface0, fg = colors.yellow },
          BufferCurrentSign = { bg = colors.surface0, fg = colors.blue },
          BufferCurrentTarget = { bg = colors.surface0, fg = colors.red },
          BufferVisible = { bg = colors.surface1, fg = colors.subtext1 },
          BufferVisibleIndex = { bg = colors.surface1, fg = colors.blue },
          BufferVisibleMod = { bg = colors.surface1, fg = colors.yellow },
          BufferVisibleSign = { bg = colors.surface1, fg = colors.blue },
          BufferVisibleTarget = { bg = colors.surface1, fg = colors.red },
          BufferInactive = { bg = colors.mantle, fg = colors.overlay0 },
          BufferInactiveIndex = { bg = colors.mantle, fg = colors.overlay0 },
          BufferInactiveMod = { bg = colors.mantle, fg = colors.yellow },
          BufferInactiveSign = { bg = colors.mantle, fg = colors.blue },
          BufferInactiveTarget = { bg = colors.mantle, fg = colors.red },

          -- Enhanced alpha dashboard
          AlphaHeader = { fg = colors.blue },
          AlphaButtons = { fg = colors.green },
          AlphaFooter = { fg = colors.lavender, style = { "italic" } },

          -- Enhanced Neo-tree highlights
          NeoTreeNormal = { bg = colors.mantle, fg = colors.text },
          NeoTreeNormalNC = { bg = colors.mantle, fg = colors.text },
          NeoTreeWinSeparator = { fg = colors.base, bg = colors.base },
          NeoTreeDirectoryIcon = { fg = colors.blue },
          NeoTreeDirectoryName = { fg = colors.blue },
          NeoTreeSymbolicLinkTarget = { fg = colors.teal },
          NeoTreeRootName = { fg = colors.blue, style = { "bold", "italic" } },
          NeoTreeFileNameOpened = { fg = colors.green },
          NeoTreeFloatBorder = { fg = colors.blue, bg = colors.mantle },
          NeoTreeFloatTitle = { fg = colors.lavender, bg = colors.mantle },
          NeoTreeTitleBar = { fg = colors.mantle, bg = colors.blue },

          -- Enhanced LSP and diagnostic highlights
          DiagnosticError = { fg = colors.red },
          DiagnosticWarn = { fg = colors.yellow },
          DiagnosticInfo = { fg = colors.sky },
          DiagnosticHint = { fg = colors.teal },
          DiagnosticVirtualTextError = { bg = colors.none, fg = colors.red, style = { "italic" } },
          DiagnosticVirtualTextWarn = { bg = colors.none, fg = colors.yellow, style = { "italic" } },
          DiagnosticVirtualTextInfo = { bg = colors.none, fg = colors.sky, style = { "italic" } },
          DiagnosticVirtualTextHint = { bg = colors.none, fg = colors.teal, style = { "italic" } },

          -- Enhanced completion menu
          PmenuSel = { bg = colors.surface1, fg = colors.text },
          PmenuSbar = { bg = colors.surface1 },
          PmenuThumb = { bg = colors.overlay0 },

          -- Enhanced git signs
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },

          -- Enhanced indent guides
          IblIndent = { fg = colors.surface0, style = { "nocombine" } },
          IblScope = { fg = colors.surface2, style = { "nocombine" } },

          -- Enhanced which-key
          WhichKey = { fg = colors.flamingo },
          WhichKeyGroup = { fg = colors.blue },
          WhichKeyDesc = { fg = colors.green },
          WhichKeySeperator = { fg = colors.overlay0 },
          WhichKeyFloat = { bg = colors.mantle },
          WhichKeyBorder = { bg = colors.mantle, fg = colors.blue },

          -- Enhanced notifications
          NotifyERRORBorder = { fg = colors.red },
          NotifyWARNBorder = { fg = colors.yellow },
          NotifyINFOBorder = { fg = colors.blue },
          NotifyDEBUGBorder = { fg = colors.overlay0 },
          NotifyTRACEBorder = { fg = colors.lavender },
          NotifyERRORIcon = { fg = colors.red },
          NotifyWARNIcon = { fg = colors.yellow },
          NotifyINFOIcon = { fg = colors.blue },
          NotifyDEBUGIcon = { fg = colors.overlay0 },
          NotifyTRACEIcon = { fg = colors.lavender },
          NotifyERRORTitle = { fg = colors.red },
          NotifyWARNTitle = { fg = colors.yellow },
          NotifyINFOTitle = { fg = colors.blue },
          NotifyDEBUGTitle = { fg = colors.overlay0 },
          NotifyTRACETitle = { fg = colors.lavender },

          -- Enhanced trouble.nvim
          TroubleNormal = { bg = colors.base },
          TroubleNormalNC = { bg = colors.base },
        }
      end,
      integrations = {
        alpha = true,
        barbar = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        fidget = true,
        gitsigns = true,
        harpoon = true,
        indent_blankline = {
          enabled = true,
          scope_color = "sapphire", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = true,
        semantic_tokens = true,
        snacks = true,
        telescope = {
          enabled = true,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    })

    -- Set colorscheme
    vim.cmd.colorscheme("catppuccin")

    -- Dynamic theme switching based on system appearance (macOS)
    if vim.fn.executable("osascript") == 1 then
      local function get_system_appearance()
        local handle = io.popen('osascript -e "tell application \\"System Events\\" to tell appearance preferences to get dark mode"')
        local result = handle and handle:read("*a") or ""
        if handle then handle:close() end
        return result:match("true") and "dark" or "light"
      end

      local function set_theme_from_system()
        local appearance = get_system_appearance()
        if appearance == "dark" then
          vim.cmd.colorscheme("catppuccin-mocha")
        else
          vim.cmd.colorscheme("catppuccin-latte")
        end
      end

      -- Set initial theme
      set_theme_from_system()

      -- Create user command to sync with system
      vim.api.nvim_create_user_command("SyncTheme", set_theme_from_system, {
        desc = "Sync theme with system appearance"
      })
    end

    -- Theme switching commands
    vim.api.nvim_create_user_command("ThemeLight", function()
      vim.cmd.colorscheme("catppuccin-latte")
    end, { desc = "Switch to light theme" })

    vim.api.nvim_create_user_command("ThemeDark", function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end, { desc = "Switch to dark theme" })

    vim.api.nvim_create_user_command("ThemeToggle", function()
      if vim.g.colors_name == "catppuccin-latte" then
        vim.cmd.colorscheme("catppuccin-mocha")
      else
        vim.cmd.colorscheme("catppuccin-latte")
      end
    end, { desc = "Toggle between light and dark theme" })

    -- Keymaps for theme switching
    vim.keymap.set("n", "<leader>tl", "<cmd>ThemeLight<CR>", { desc = "Light theme" })
    vim.keymap.set("n", "<leader>td", "<cmd>ThemeDark<CR>", { desc = "Dark theme" })
    vim.keymap.set("n", "<leader>tt", "<cmd>ThemeToggle<CR>", { desc = "Toggle theme" })
    vim.keymap.set("n", "<leader>ts", "<cmd>SyncTheme<CR>", { desc = "Sync with system theme" })

    -- Auto-sync with system theme on focus (optional)
    local sync_group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })
    vim.api.nvim_create_autocmd("FocusGained", {
      group = sync_group,
      callback = function()
        if vim.fn.executable("osascript") == 1 then
          vim.defer_fn(function()
            vim.cmd("silent! SyncTheme")
          end, 100)
        end
      end,
    })
  end,
}
