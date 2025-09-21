# Alpha Dashboard Configuration

A beautiful, functional Neovim dashboard using [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) with enhanced features and dynamic content.

## Features

### 🎨 Visual Elements
- **Custom ASCII Header**: Neovim logo art for branding
- **Dynamic Footer**: 
  - Real-time plugin loading stats (count + startup time)
  - Rotating inspirational coding quotes
  - Performance metrics display

### 🔧 Quick Actions
The dashboard provides instant access to common workflows:

#### File Operations
- `n` - **New file**: Create a blank file
- `f` - **Find file**: Search files in current directory (Telescope)
- `g` - **Find in git**: Search files in git repository (git-tracked files only)
- `r` - **Recent files**: Browse recently opened files
- `w` - **Find word**: Live grep search across files

#### Project Navigation
- `p` - **Projects**: Navigate to `~/git` directory and open Neo-tree
- `d` - **Dotfiles**: Navigate to `~/dotfiles` and open Neo-tree  
- `s` - **Settings**: Open Neovim configuration directory

#### Tools & Management
- `e` - **LazyGit**: Open LazyGit for git operations
- `l` - **Lazy**: Plugin manager interface
- `m` - **Mason**: LSP server manager
- `q` - **Quit**: Exit Neovim

### 🎯 Smart Features
- **Dynamic stats**: Shows actual plugin loading performance
- **Quote rotation**: Displays random coding wisdom on each startup
- **Visual spacing**: Organized button groups with proper padding
- **Snacks integration**: Uses modern LazyGit implementation via Snacks.nvim

## Configuration Structure

```lua
-- Core setup
require("alpha").setup(dashboard.opts)

-- Header: ASCII art logo
dashboard.section.header.val = { ... }

-- Buttons: Quick action menu
dashboard.section.buttons.val = {
  dashboard.button("key", "icon  description", "command"),
  -- ...
}

-- Footer: Dynamic stats + quotes
dashboard.section.footer.val = get_footer()
```

## Customization

### Changing the Header
Replace the ASCII art in `dashboard.section.header.val` with your preferred design:

```lua
dashboard.section.header.val = {
  "Your custom",
  "ASCII art here",
}
```

### Adding New Buttons
Insert additional buttons in `dashboard.section.buttons.val`:

```lua
dashboard.button("k", "🔑  New Action", "<cmd>YourCommand<CR>"),
```

### Custom Quotes
Modify the quotes array in the `get_footer()` function:

```lua
local quotes = {
  '"Your custom quote here"',
  '"Another inspiring message"',
}
```

### Color Customization
The configuration includes custom highlighting:
- **Header**: Blue color (`Number` highlight group)
- **Buttons**: Green color (`String` highlight group)  
- **Footer**: Muted purple (`Comment` highlight group)

Override these by changing the highlight group assignments:

```lua
dashboard.section.header.opts.hl = "YourHighlightGroup"
```

## Integration Points

### Telescope
- File finding (`f`, `g`, `r`, `w`) uses Telescope pickers
- Requires telescope.nvim to be installed and configured

### Neo-tree
- Project navigation (`p`, `d`, `s`) opens Neo-tree file explorer
- Uses `reveal` mode to show files in the target directory

### Snacks.nvim  
- LazyGit integration (`e`) uses modern Snacks.nvim implementation
- Provides better terminal integration than traditional LazyGit plugins

### Lazy.nvim
- Footer stats (`l`) pulls real plugin loading metrics
- Shows actual startup performance data

## File Structure Impact

This configuration affects:
- **Startup experience**: Provides welcoming dashboard on empty Neovim launch  
- **Workflow efficiency**: Quick access to common operations
- **Visual consistency**: Matches your Catppuccin theme
- **Performance awareness**: Shows startup metrics for optimization

## Keyboard Shortcuts

| Key | Action | Command | Description |
|-----|--------|---------|-------------|
| `n` | New file | `:ene` | Create blank buffer |
| `f` | Find file | `Telescope find_files` | Search current directory |
| `g` | Git files | `Telescope git_files` | Search git-tracked files |
| `r` | Recent | `Telescope oldfiles` | Recently opened files |
| `w` | Word search | `Telescope live_grep` | Search text in files |
| `p` | Projects | `cd ~/git + Neo-tree` | Browse projects |
| `d` | Dotfiles | `cd ~/dotfiles + Neo-tree` | Edit dotfiles |
| `s` | Settings | `cd ~/.config/nvim + Neo-tree` | Neovim config |
| `e` | Git UI | `Snacks.lazygit.open()` | LazyGit interface |
| `l` | Plugins | `:Lazy` | Plugin manager |
| `m` | LSP | `:Mason` | Language servers |
| `q` | Quit | `:qa` | Exit Neovim |

## Dependencies

Required plugins for full functionality:
- `nvim-telescope/telescope.nvim` - File finding and search
- `nvim-neo-tree/neo-tree.nvim` - File explorer  
- `folke/snacks.nvim` - LazyGit integration
- `folke/lazy.nvim` - Plugin management and stats
- `williamboman/mason.nvim` - LSP server management

## Tips

1. **Performance**: The footer shows real startup time - use it to monitor plugin load performance
2. **Customization**: Buttons are easily reorderable and customizable for your workflow
3. **Theming**: Dashboard respects your colorscheme and integrates with Catppuccin
4. **Navigation**: Use the dashboard as your daily Neovim starting point for consistent workflow
5. **Projects**: Adjust the projects path (`~/git`) to match your development directory structure

## Troubleshooting

### LazyGit Button Not Working
- Ensure Snacks.nvim is installed and configured
- Check that LazyGit is available in your system PATH

### File Navigation Issues  
- Verify Neo-tree is properly installed
- Ensure directory paths exist (`~/git`, `~/dotfiles`)

### Telescope Integration Problems
- Confirm telescope.nvim is loaded
- Check telescope configuration for find_files, git_files, and live_grep

### Stats Not Showing
- Verify Lazy.nvim is properly configured
- Check that `require("lazy").stats()` returns valid data