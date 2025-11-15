return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" }, -- load when a file is opened
		opts = {
			ensure_installed = {
				"go",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},

			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
				disable = { "python", "yaml" },
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
					},
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			-- ensure the module is present; lazy.nvim guarantees plugin is loaded here
			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ok then
				vim.schedule(function()
					vim.notify("nvim-treesitter not available", vim.log.levels.WARN)
				end)
				return
			end
			configs.setup(opts)

			-- Treesitter-based folding
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false
		end,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "nvim-treesitter/nvim-treesitter-context" },
		},
	},

	-- Load context after treesitter; it will inherit the loaded parser
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 20,
			multiline_threshold = 1,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
		},
		keys = {
			{
				"<leader>tc",
				function()
					require("treesitter-context").toggle()
				end,
				desc = "Toggle treesitter context",
			},
			{
				"[c",
				function()
					require("treesitter-context").go_to_context()
				end,
				desc = "Jump to context",
			},
		},
	},
}
