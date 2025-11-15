return { -- Highly extendable fuzzy finder
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = true },
		"debugloop/telescope-undo.nvim",
	},

	config = function()
		require("telescope").setup({
			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.6,
					},
				},
			},
			defaults = {
				winblend = 20,
				previewer = true,
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "undo")

		local builtin = require("telescope.builtin")
		local ivy = require("telescope.themes").get_ivy()

		vim.keymap.set("n", "<leader>sh", function()
			builtin.help_tags(ivy)
		end, { desc = "[S]earch [H]elp" })

		vim.keymap.set("n", "<leader>gf", function()
			builtin.git_files(ivy)
		end, { desc = "[G]it [F]ile Search" })

		vim.keymap.set("n", "<leader>sk", function()
			builtin.keymaps(ivy)
		end, { desc = "[S]earch [K]eymaps" })

		vim.keymap.set("n", "<leader>sf", function()
			builtin.find_files(ivy)
		end, { desc = "[S]earch [F]iles" })

		vim.keymap.set("n", "<leader>ps", function()
			builtin.live_grep(ivy)
		end, { desc = "[S]earch by [G]rep" })

		vim.keymap.set("n", "<leader>gw", function()
			builtin.grep_string(ivy)
		end, { desc = "[G]rep current [W]ord" })

		vim.keymap.set("n", "<leader>rc", function()
			builtin.commands(ivy)
		end, { desc = "[R]un [C]ommand" })

		vim.keymap.set("n", "<leader><leader>", function()
			builtin.buffers(ivy)
		end, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>uu", "<cmd>Telescope undo<CR>", { desc = "[ ] Find existing buffers" })
	end,
}
