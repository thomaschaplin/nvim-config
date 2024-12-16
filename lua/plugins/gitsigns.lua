return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>',
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        })
        vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
    end
}
