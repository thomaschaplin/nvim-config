return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Global LSP keymaps using Neovim 0.11 defaults where possible
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }

        -- Use new default keymaps where available
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, opts)
        vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)

        -- Keep common keymaps
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format { async = true }
        end, opts)

        -- Workspace folders
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
      end,
    })

    -- Load LSP configurations from lsp/ directory
    local config_path = vim.fn.stdpath("config")

    -- Load gopls config
    local gopls_config = dofile(config_path .. "/lsp/gopls.lua")
    vim.lsp.config.gopls = gopls_config

    -- Load lua_ls config
    local lua_ls_config = dofile(config_path .. "/lsp/lua_ls.lua")
    vim.lsp.config.lua_ls = lua_ls_config
  end,
}