return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")

		npairs.setup({
			-- Basic settings
			check_ts = true, -- Use treesitter for better pair detection
			ts_config = {
				lua = { "string", "source" }, -- Don't add pairs in lua string treesitter nodes
				javascript = { "string", "template_string" },
				typescript = { "string", "template_string" },
				java = false, -- Don't check treesitter on java
			},
			
			-- Disable autopairs for certain filetypes
			disable_filetype = { "TelescopePrompt", "spectre_panel", "alpha" },
			disable_in_macro = false, -- Disable when recording or executing a macro
			disable_in_visualblock = false, -- Disable when selecting in visual block mode
			disable_in_replace_mode = true,
			
			-- Pair behavior settings
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=], -- Pattern to ignore next character
			enable_moveright = true,
			enable_afterquote = true, -- Add bracket pairs after quote
			enable_check_bracket_line = true, -- Check bracket in same line
			enable_bracket_in_quote = true,
			enable_abbr = false, -- Trigger abbreviation
			break_undo = true, -- Switch for basic rule break undo sequence
			
			-- Advanced mapping settings
			map_cr = true, -- Map <CR> key
			map_bs = true, -- Map backspace key
			map_c_h = false, -- Map <C-h> to delete a pair
			map_c_w = false, -- Map <C-w> to delete a pair if possible
		})

		-- Integration with nvim-cmp for better completion experience
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Custom rules for better language support
		local ts_conds = require("nvim-autopairs.ts-conds")

		-- Add spaces inside function calls for certain languages
		npairs.add_rules({
			Rule(" ", " ")
				:with_pair(function(opts)
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({ "()", "[]", "{}" }, pair)
				end),
			
			-- Add arrow function support for JavaScript/TypeScript
			Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
				:use_regex(true)
				:set_end_pair_length(2),
		})

		-- Language-specific rules
		
		-- HTML/JSX - Auto close tags
		npairs.add_rules({
			Rule("<", ">"):with_pair(cond.before_regex("%a+:?:?$", 1)),
			Rule("<", " />"):with_pair(function() return false end),
		})

		-- Go - Add custom rules for Go
		npairs.add_rules({
			Rule("if err != nil {", " }", "go"):set_end_pair_length(2),
		})

		-- Rust - Add custom rules for Rust
		npairs.add_rules({
			Rule("if let ", " {", "rust"):set_end_pair_length(2),
			Rule("match ", " {", "rust"):set_end_pair_length(2),
		})

		-- Python - Add custom rules for Python
		npairs.add_rules({
			Rule("f'", "'", "python"),
			Rule('f"', '"', "python"),
			Rule("r'", "'", "python"),
			Rule('r"', '"', "python"),
		})

		-- Lua - Add custom rules for Lua
		npairs.add_rules({
			Rule("function", "end", "lua")
				:with_pair(cond.not_before_regex("end", 3))
				:use_key("function")
				:replace_endpair(function() return "<space>end" end, true),
		})

		-- Markdown - Special rules for markdown
		npairs.add_rules({
			Rule("**", "**", "markdown"),
			Rule("__", "__", "markdown"),
			Rule("***", "***", "markdown"),
		})

		-- Enhanced CR (Enter) behavior
		local cr_action = require("nvim-autopairs.conds").done()
		npairs.setup({
			map_cr = true,
		})

		-- Custom keymaps for better control
		vim.keymap.set("i", "<C-h>", function()
			if vim.fn.pumvisible() ~= 0 then
				return "<C-h>"
			else
				return require("nvim-autopairs").autopairs_bs()
			end
		end, { expr = true, replace_keycodes = false })

		-- Toggle autopairs on/off
		vim.keymap.set("n", "<leader>ap", function()
			local ok, autopairs = pcall(require, "nvim-autopairs")
			if ok then
				if autopairs.state.disabled then
					autopairs.enable()
					vim.notify("Autopairs enabled", vim.log.levels.INFO)
				else
					autopairs.disable()
					vim.notify("Autopairs disabled", vim.log.levels.INFO)
				end
			end
		end, { desc = "Toggle autopairs" })

		-- Fast wrap feature - select text and press Alt+e to wrap with pairs
		npairs.add_rules({
			Rule("", "")
				:with_move(cond.none())
				:with_pair(cond.none())
				:with_del(cond.none())
				:use_key("<M-e>")
				:replace_endpair(function(opts)
					return "<ESC>:lua require('nvim-autopairs.fastwrap').fastwrap_move()<CR>"
				end, false),
		})

		-- Setup fast wrap
		require("nvim-autopairs.fastwrap").setup({
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = [=[[%'%"%)%>%]%)%}%,]]=],
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "Search",
			highlight_grey = "Comment",
		})
	end,
}
