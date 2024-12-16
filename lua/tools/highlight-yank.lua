vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 400, visual = true })
	end,
})
