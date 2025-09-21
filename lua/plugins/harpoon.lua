return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- Setup harpoon with enhanced configuration
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				key = function()
					return vim.loop.cwd()
				end,
			},
		})

		-- Enhanced keymaps for better workflow
		local keymap = vim.keymap.set

		-- Core harpoon functions
		keymap("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
		keymap("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle menu" })

		-- Quick navigation to harpooned files
		keymap("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to file 1" })
		keymap("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to file 2" })
		keymap("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to file 3" })
		keymap("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to file 4" })
		keymap("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon: Go to file 5" })

		-- Alternative navigation with Ctrl (for those who prefer it)
		keymap("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to file 1" })
		keymap("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to file 2" })
		keymap("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to file 3" })
		keymap("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to file 4" })

		-- Navigation between harpooned files
		keymap("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon: Previous file" })
		keymap("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon: Next file" })

		-- Clear all harpoon marks (useful for project switching)
		keymap("n", "<leader>hc", function()
			harpoon:list():clear()
			vim.notify("🗑️  Cleared all harpoon marks", vim.log.levels.INFO, { title = "Harpoon" })
		end, { desc = "Harpoon: Clear all marks" })

		-- Remove current file from harpoon
		keymap("n", "<leader>hr", function()
			harpoon:list():remove()
			vim.notify("❌ Removed current file from harpoon", vim.log.levels.INFO, { title = "Harpoon" })
		end, { desc = "Harpoon: Remove current file" })

		-- Telescope integration for harpoon files
		keymap("n", "<leader>fh", function()
			local conf = require("telescope.config").values
			local file_paths = {}
			for _, item in ipairs(harpoon:list().items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon Files",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end, { desc = "Harpoon: Search harpooned files" })

		-- Auto-commands for better integration
		local autocmd = vim.api.nvim_create_autocmd
		local augroup = vim.api.nvim_create_augroup("Harpoon", { clear = true })

		-- Show notification when adding files
		autocmd("User", {
			pattern = "HarpoonAdd",
			callback = function()
				local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
				vim.notify("📌 Added " .. filename .. " to harpoon", vim.log.levels.INFO, { title = "Harpoon" })
			end,
			group = augroup,
		})

		-- Display harpoon marks in statusline (optional integration)
		vim.g.harpoon_status = function()
			local marks = harpoon:list()
			if marks and #marks.items > 0 then
				local current_file = vim.fn.expand("%:p")
				for i, mark in ipairs(marks.items) do
					local mark_path = mark.value
					if mark_path == current_file or mark_path == vim.fn.expand("%") then
						return "🎯 " .. i
					end
				end
				return "📌 " .. #marks.items
			end
			return ""
		end

		-- Integration with existing session management
		-- Harpoon automatically saves per-directory, so it works well with your sessions
	end,
}
