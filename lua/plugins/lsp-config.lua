return {
  -- LazyDev Plugin: Configures Lua LSP for Neovim configs and runtime
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  -- Luvit Meta Plugin: Provides Lua types for Luvit
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
  -- Main LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim",       opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        helm_ls = {},
        docker_compose_language_service = {},
        cssls = {},
        bashls = {},
        terraformls = {},
        yamlls = {},
        gopls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      }

      require("mason").setup()

      -- Mason package names (different from LSP server names)
      local mason_packages = {
        "helm-ls",
        "docker-compose-language-service", 
        "css-lsp",
        "bash-language-server",
        "terraform-ls",
        "yaml-language-server",
        "gopls",
        "lua-language-server",
      }
      require("mason-tool-installer").setup({ ensure_installed = mason_packages })
      
      -- Setup LSP servers manually with error handling
      for server_name, server_config in pairs(servers) do
        local ok, _ = pcall(function()
          server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
          vim.lsp.config(server_name, server_config)
        end)
        if not ok then
          vim.notify("Failed to setup LSP server: " .. server_name, vim.log.levels.WARN)
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
          )
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}
