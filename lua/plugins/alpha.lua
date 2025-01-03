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
      dashboard.button("n", "🆕  > New file", ":ene<CR>"),
      dashboard.button("g", "🔍  > Find file (git)", ":cd $HOME/GIT | Telescope find_files<CR>"),
      dashboard.button("f", "🔍  > Find file (cwd)", ":Telescope find_files<CR>"),
      dashboard.button("r", "📌  > Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("p", "🗂️  > Projects", ":cd $HOME/git | Neotree filesystem toggle float<CR>"),
      dashboard.button("o", "🗃️  > Open Filesystem", ":Neotree filesystem toggle float<CR>"),
      dashboard.button("e", "🪴  > Open LazyGit", ":LazyGit<CR>"),
      dashboard.button("d", "💬  > Dotfiles", ":cd $HOME/dotfiles | Neotree filesystem toggle float<CR>"),
      dashboard.button("s", "⚙️   > Settings", ":cd ~/.config/nvim | Neotree filesystem toggle float<CR>"),
      dashboard.button("l", "💤  > Lazy", ":Lazy<CR>"),
      dashboard.button("q", "⛔️  > Quit NVIM", ":qa<CR>"),
    }

    dashboard.section.footer.val = 'Success - "We cannot direct the wind but we can adjust the sails"'

    alpha.setup(dashboard.opts)
  end,
}
