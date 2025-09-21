return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      -- Terminal settings
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      
      -- Key mappings
      open_mapping = [[<c-j>]], -- Your current mapping
      hide_numbers = true, -- Hide the number column in toggleterm buffers
      shade_filetypes = {},
      autochdir = true, -- When neovim changes directory, so does the terminal
      
      -- Clean shell configuration
      shell = vim.o.shell,
      env = {
        TERM = "xterm-256color",
        -- Tell zsh this is running inside Neovim
        INSIDE_NEOVIM = "1",
      },
      
      -- Float terminal settings
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function() 
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 0,
        zindex = 1000,
      },
      
      -- Window options
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end
      },

      -- Prevent closing last window error
      close_on_exit = false,
      auto_scroll = true,
      
      -- Terminal behavior
      start_in_insert = true,
      insert_mappings = true, -- Apply open_mapping in insert mode
      terminal_mappings = true, -- Apply open_mapping in terminal mode
      persist_size = true,
      persist_mode = true, -- Remember last mode (insert/normal)
      
      
      on_open = function(term)
        vim.cmd("startinsert!")
        -- Additional key mappings for terminal mode
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], {
          noremap = true, 
          silent = true,
          desc = "Exit terminal mode"
        })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-h>", [[<Cmd>wincmd h<CR>]], {
          noremap = true,
          silent = true, 
          desc = "Navigate left"
        })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-l>", [[<Cmd>wincmd l<CR>]], {
          noremap = true,
          silent = true,
          desc = "Navigate right"
        })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-k>", [[<Cmd>wincmd k<CR>]], {
          noremap = true,
          silent = true,
          desc = "Navigate up"
        })
      end,
      
      on_close = function(term)
        -- Only start insert if we have more than one window
        if vim.fn.winnr('$') > 1 then
          vim.cmd("startinsert!")
        end
      end,
    })

    -- Enhanced terminal management functions
    local Terminal = require("toggleterm.terminal").Terminal

    -- Create specialized terminals

    local node_repl = Terminal:new({
      cmd = "node",
      direction = "horizontal",
      close_on_exit = false,
    })

    local python_repl = Terminal:new({
      cmd = "python3",
      direction = "horizontal", 
      close_on_exit = false,
    })

    local btop = Terminal:new({
      cmd = "btop || top",
      direction = "float",
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })

    -- Custom terminal functions
    function _G.node_repl_toggle()
      node_repl:toggle()
    end

    function _G.python_repl_toggle() 
      python_repl:toggle()
    end

    function _G.btop_toggle()
      btop:toggle()
    end

    -- Enhanced key mappings
    local opts = { noremap = true, silent = true }
    
    -- Basic terminal toggle (your existing C-j)
    vim.keymap.set({"n", "t"}, "<C-j>", "<cmd>ToggleTerm<CR>", 
      vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))
    
    -- Specialized terminals
    vim.keymap.set("n", "<leader>tn", "<cmd>lua node_repl_toggle()<CR>", 
      vim.tbl_extend("force", opts, { desc = "Toggle Node REPL" }))
    vim.keymap.set("n", "<leader>tp", "<cmd>lua python_repl_toggle()<CR>", 
      vim.tbl_extend("force", opts, { desc = "Toggle Python REPL" }))
    vim.keymap.set("n", "<leader>tm", "<cmd>lua btop_toggle()<CR>", 
      vim.tbl_extend("force", opts, { desc = "Toggle system monitor" }))
    
    -- Terminal direction toggles
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", 
      vim.tbl_extend("force", opts, { desc = "Horizontal terminal" }))
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", 
      vim.tbl_extend("force", opts, { desc = "Vertical terminal" }))
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", 
      vim.tbl_extend("force", opts, { desc = "Floating terminal" }))
    
    -- Multiple terminal management
    vim.keymap.set("n", "<leader>1", "<cmd>1ToggleTerm<CR>", 
      vim.tbl_extend("force", opts, { desc = "Terminal 1" }))
    vim.keymap.set("n", "<leader>2", "<cmd>2ToggleTerm<CR>", 
      vim.tbl_extend("force", opts, { desc = "Terminal 2" }))
    vim.keymap.set("n", "<leader>3", "<cmd>3ToggleTerm<CR>", 
      vim.tbl_extend("force", opts, { desc = "Terminal 3" }))
  end,
}
