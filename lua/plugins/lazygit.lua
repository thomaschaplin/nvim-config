return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    lazygit = {
      enabled = true,
      configure = true,
      config = {
        os = {
          editPreset = "nvim-remote",
          edit = "nvim {{filename}}",
          editAtLine = "nvim +{{line}} {{filename}}",
          editAtLineAndWait = "nvim +{{line}} {{filename}}",
          openDirInEditor = "nvim {{dir}}",
        },
        gui = {
          nerdFontsVersion = "3",
          showFileTree = true,
          showRandomTip = false,
          mouseEvents = true,
          skipDiscardChangeWarning = false,
          skipStashWarning = false,
          sidePanelWidth = 0.333,
          expandFocusedSidePanel = false,
          mainPanelSplitMode = "flexible",
          enlargedSideViewLocation = "left",
          language = "auto",
          timeFormat = "02 Jan 06",
          shortTimeFormat = "15:04",
          theme = {
            lightTheme = false,
            activeBorderColor = { "#89b4fa", "bold" },
            inactiveBorderColor = { "#45475a" },
            optionsTextColor = { "#89b4fa" },
            selectedLineBgColor = { "#313244" },
            selectedRangeBgColor = { "#313244" },
            cherryPickedCommitBgColor = { "#45475a" },
            cherryPickedCommitFgColor = { "#89b4fa" },
            unstagedChangesColor = { "#f38ba8" },
            defaultFgColor = { "#cdd6f4" },
            searchingActiveBorderColor = { "#f9e2af", "bold" },
          },
          commitLength = {
            show = true,
          },
          skipHookPrefix = "WIP",
          autoFetch = true,
          autoRefresh = true,
          branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --",
          allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium",
          overrideGpg = false,
          disableStartupPopups = false,
          showCommandLog = false,
          showBottomLine = true,
          showPanelJumps = true,
          showBranchCommitHash = false,
          commandLogSize = 8,
          splitDiff = "auto",
        },
        git = {
          paging = {
            colorArg = "always",
            pager = vim.fn.executable("delta") == 1 and "delta --dark --paging=never" or "less"
          },
          merging = {
            manualCommit = false,
            args = "",
          },
          log = {
            date = "default",
            order = "topo-order",
            showGraph = "when-maximised",
            showWholeGraph = false,
          },
          skipHookPrefix = "WIP",
          autoFetch = true,
          autoRefresh = true,
          branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --",
          allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative --pretty=medium",
          overrideGpg = false,
        },
        update = {
          method = "prompt",
          days = 14,
        },
        refresher = {
          refreshInterval = 10,
          fetchInterval = 60,
        },
        confirmOnQuit = false,
        quitOnTopLevelReturn = false,
        disableStartupPopups = false,
        notARepository = "prompt",
        promptToReturnFromSubprocess = true,
      },
      theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
      win = {
        style = "lazygit",
        backdrop = 60,
        height = 0.9,
        width = 0.9,
        wo = {
          winhighlight = "Normal:SnacksLazygitNormal,NormalNC:SnacksLazygitNormalNC",
        },
        keys = {
          q = "close",
        },
      },
    },
    gitbrowse = {
      enabled = true,
      notify = true,
      what = "file",
      branch = nil,
      line_start = nil,
      line_end = nil,
      remote = nil,
      open = function(url)
        vim.ui.open(url)
      end,
    },
    picker = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>lg",
      function()
        Snacks.lazygit.open()
      end,
      desc = "LazyGit",
    },
    {
      "<leader>lglf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "LazyGit Log File",
    },
    {
      "<leader>lgl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "LazyGit Log",
    },
    {
      "<leader>gb",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse({
          what = "repo",
        })
      end,
      desc = "Git Browse Repository",
    },
    {
      "<leader>gbl",
      function()
        Snacks.gitbrowse({
          what = "file",
          line_start = vim.fn.line("."),
          line_end = vim.fn.line("v") ~= vim.fn.line(".") and vim.fn.line("v") or nil,
        })
      end,
      mode = { "n", "v" },
      desc = "Git Browse File at Line",
    },
    {
      "<leader>gbc",
      function()
        local commit = vim.fn.input("Commit hash: ")
        if commit and commit ~= "" then
          Snacks.gitbrowse({
            what = "commit",
            commit = commit,
          })
        end
      end,
      desc = "Git Browse Commit",
    },
    {
      "<leader>lgf",
      function()
        Snacks.lazygit.log_file({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "LazyGit Current File",
    },
    {
      "<leader>lgb",
      function()
        local branch = vim.fn.input("Branch name: ")
        if branch and branch ~= "" then
          Snacks.lazygit.open({ args = { "--filter=" .. branch } })
        end
      end,
      desc = "LazyGit Branch Filter",
    },
  },
}
