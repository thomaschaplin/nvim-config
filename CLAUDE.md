# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a modular Neovim configuration built using Lazy.nvim as the plugin manager. The configuration follows a clean separation of concerns with three main directories:

- `lua/user/`: Core user settings, options, and lazy.nvim bootstrap
- `lua/plugins/`: Individual plugin configurations (one file per plugin)
- `lua/tools/`: Utility functions and tools for Neovim enhancements

The main entry point is `init.lua` which simply requires the `user` and `tools` modules. The `user/lazy.lua` file bootstraps Lazy.nvim and loads all plugin configurations from the `plugins/` directory.

## Plugin Management

All plugins are managed through Lazy.nvim and configured in separate files within `lua/plugins/`. Each plugin file returns a Lua table with the plugin specification. New plugins should follow this pattern:

```lua
return {
  "author/plugin-name",
  config = function()
    -- plugin configuration
  end
}
```

## Key Configuration Files

- `lua/user/options.lua`: Contains all Vim options and basic key mappings
- `lua/user/lazy.lua`: Lazy.nvim bootstrap and plugin loading
- `lua/plugins/lsp-config.lua`: LSP configuration using Mason for LSP management
- `lua/plugins/none-ls.lua`: Formatting configuration (uses formatter.nvim)
- `lua/plugins/completions.lua`: Autocompletion setup
- `lua/plugins/treesitter.lua`: Syntax highlighting and parsing

## Language Support

The configuration includes specific language configurations:
- `lua/plugins/golang.lua`: Go development with gopls LSP
- `lua/plugins/terraform.lua`: Terraform support
- `lua/plugins/helm.lua`: Helm chart support

## Core Settings

- Leader key: `<Space>`
- Tab width: 2 spaces
- Line numbers: Enabled with relative numbering
- Mouse support: Enabled
- Clipboard: System clipboard integration
- Theme: Catppuccin

## Development Workflow

When adding new plugins:
1. Create a new file in `lua/plugins/` named after the plugin
2. Follow the existing plugin configuration patterns
3. Test the configuration by restarting Neovim
4. Lazy.nvim will automatically detect and load the new plugin

When modifying options:
- Edit `lua/user/options.lua` for Vim options
- Add key mappings in the appropriate plugin file or options.lua

## Key Tools and Features

- **LSP**: Configured via Mason for automatic LSP server management
- **Formatting**: Uses formatter.nvim with language-specific formatters
- **File Navigation**: Neo-tree for file explorer, Telescope for fuzzy finding
- **Git Integration**: Fugitive, Gitsigns, and Lazygit
- **Terminal**: Toggleterm for integrated terminal
- **Session Management**: Auto-sessions for workspace persistence