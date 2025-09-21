return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "🆕  New file", "<cmd>ene<CR>"),
      dashboard.button("f", "🔍  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("g", "🔎  Find in git", "<cmd>Telescope git_files<CR>"),
      dashboard.button("r", "📁  Recent files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("w", "🔤  Find word", "<cmd>Telescope live_grep<CR>"),
      { type = "padding", val = 1 },
      dashboard.button("p", "📂  Projects", "<cmd>cd $HOME/git | Neotree filesystem toggle float<CR>"),
      dashboard.button("d", "⚙️  Dotfiles", "<cmd>cd $HOME/dotfiles | Neotree filesystem toggle float<CR>"),
      dashboard.button("s", "🛠️  Settings", "<cmd>cd ~/.config/nvim | Neotree filesystem toggle float<CR>"),
      { type = "padding", val = 1 },
      dashboard.button("e", "🌿  LazyGit", function() require("snacks").lazygit.open() end),
      dashboard.button("l", "💤  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("m", "🩺  Mason", "<cmd>Mason<CR>"),
      { type = "padding", val = 1 },
      dashboard.button("q", "❌  Quit", "<cmd>qa<CR>"),
    }

    -- Dynamic footer with stats
    local function get_footer()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      local plugins_text = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      local quotes = {
        '"We cannot direct the wind but we can adjust the sails"',
        '"Code is like humor. When you have to explain it, it\'s bad." - Cory House',
        '"First, solve the problem. Then, write the code." - John Johnson',
        '"The best error message is the one that never shows up." - Thomas Fuchs',
      }
      local quote = quotes[math.random(#quotes)]
      return { "", plugins_text, "", quote }
    end

    dashboard.section.footer.val = get_footer()

    -- Custom highlighting
    dashboard.section.header.opts.hl = "Number"
    dashboard.section.buttons.opts.hl = "String"
    dashboard.section.footer.opts.hl = "Comment"

    alpha.setup(dashboard.opts)
  end,
}
