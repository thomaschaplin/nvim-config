return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  event = "BufAdd",
  config = function()
    require("barbar").setup({
      -- Enable/disable animations
      animation = true,

      -- Enable/disable auto-hiding the tab bar when there is a single buffer
      auto_hide = false,

      -- Enable/disable current/total tabpages indicator (top right corner)
      tabpages = true,

      -- Enables/disable clickable tabs
      clickable = true,

      -- Excludes buffers from the tabline
      exclude_ft = { "javascript" },
      exclude_name = { "package.json" },

      -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
      focus_on_close = "left",

      -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
      hide = { extensions = true, inactive = false },

      -- Disable highlighting alternate buffers
      highlight_alternate = false,

      -- Disable highlighting file icons in inactive buffers
      highlight_inactive_file_icons = false,

      -- Enable highlighting visible buffers
      highlight_visible = true,

      icons = {
        -- Configure the base icons on the bufferline.
        buffer_index = false,
        buffer_number = false,
        button = "",
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "󰅚 " },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = "󰀪 " },
          [vim.diagnostic.severity.INFO] = { enabled = true, icon = "󰋽 " },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = "󰌶 " },
        },
        gitsigns = {
          added = { enabled = true, icon = "+" },
          changed = { enabled = true, icon = "~" },
          deleted = { enabled = true, icon = "-" },
        },
        -- Configure the icons on the bufferline when modified or pinned.
        filetype = {
          -- Sets the icon's highlight group.
          custom_colors = false,
          -- Requires `nvim-web-devicons`
          enabled = true,
        },
        separator = { left = "▎", right = "" },
        -- Configure the icons on the bufferline based on the visibility of the buffer.
        preset = "default",
        -- Configure the icons on the bufferline when modified or pinned.
        alternate = { filetype = { enabled = false } },
        current = { buffer_index = true },
        inactive = { button = "×" },
        visible = { modified = { buffer_number = false } },
      },

      -- If true, new buffers will be inserted at the start/end of the list.
      insert_at_end = false,
      insert_at_start = false,

      -- Sets the maximum padding width with which to surround each tab
      maximum_padding = 1,

      -- Sets the minimum padding width with which to surround each tab
      minimum_padding = 1,

      -- Sets the maximum buffer name length.
      maximum_length = 30,

      -- Sets the minimum buffer name length.
      minimum_length = 0,

      -- If set, the letters for each buffer in buffer-pick mode will be
      -- assigned based on their name. Otherwise or in case all letters are
      -- already assigned, the behavior is to assign letters in alphabetical
      -- order.
      semantic_letters = true,

      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = nil}
        NvimTree = true,
        -- Or, specify the text used for the offset:
        undotree = {
          text = "undotree",
          align = "center", -- *optionally* set an alignment (either 'left', 'center', or 'right')
        },
        -- Or, specify the event which the sidebar executes when leaving:
        ["neo-tree"] = { event = "BufWipeout" },
        -- Or, specify all three
        Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
      },

      -- New buffer letters are assigned in this order. This order is
      -- optimal for the qwerty keyboard layout but might need adjustment
      -- for other layouts.
      letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

      -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
      -- where X is the buffer number. But only a static string is accepted here.
      no_name_title = nil,
    })

    -- Enhanced keymaps for better buffer management
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Move to previous/next buffer
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))

    -- Re-order to previous/next
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", vim.tbl_extend("force", opts, { desc = "Move buffer left" }))
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", vim.tbl_extend("force", opts, { desc = "Move buffer right" }))

    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 1" }))
    map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 2" }))
    map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 3" }))
    map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 4" }))
    map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 5" }))
    map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 6" }))
    map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 7" }))
    map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 8" }))
    map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", vim.tbl_extend("force", opts, { desc = "Goto buffer 9" }))
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", vim.tbl_extend("force", opts, { desc = "Goto last buffer" }))

    -- Pin/unpin buffer
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", vim.tbl_extend("force", opts, { desc = "Pin/unpin buffer" }))

    -- Close buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", vim.tbl_extend("force", opts, { desc = "Close buffer" }))
    map("n", "<A-C>", "<Cmd>BufferClose!<CR>", vim.tbl_extend("force", opts, { desc = "Force close buffer" }))

    -- Close commands
    map("n", "<leader>bc", "<Cmd>BufferClose<CR>", vim.tbl_extend("force", opts, { desc = "Close buffer" }))
    map("n", "<leader>bC", "<Cmd>BufferClose!<CR>", vim.tbl_extend("force", opts, { desc = "Force close buffer" }))
    map("n", "<leader>bca", "<Cmd>BufferCloseAllButCurrent<CR>", vim.tbl_extend("force", opts, { desc = "Close all but current" }))
    map("n", "<leader>bcl", "<Cmd>BufferCloseBuffersLeft<CR>", vim.tbl_extend("force", opts, { desc = "Close all left" }))
    map("n", "<leader>bcr", "<Cmd>BufferCloseBuffersRight<CR>", vim.tbl_extend("force", opts, { desc = "Close all right" }))

    -- Buffer pick mode
    -- map("n", "<C-p>", "<Cmd>BufferPick<CR>", vim.tbl_extend("force", opts, { desc = "Buffer pick" }))

    -- Sort automatically by...
    map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", vim.tbl_extend("force", opts, { desc = "Sort by buffer number" }))
    map("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", vim.tbl_extend("force", opts, { desc = "Sort by directory" }))
    map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", vim.tbl_extend("force", opts, { desc = "Sort by language" }))
    map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", vim.tbl_extend("force", opts, { desc = "Sort by window number" }))

    -- Custom commands for better workflow
    vim.api.nvim_create_user_command("BufferCloseAllButPinned", function()
      vim.cmd("BufferCloseAllButPinned")
    end, { desc = "Close all buffers except pinned ones" })

    vim.api.nvim_create_user_command("BufferCloseAllButCurrentOrPinned", function()
      vim.cmd("BufferCloseAllButCurrentOrPinned")
    end, { desc = "Close all buffers except current and pinned" })
  end,
}
