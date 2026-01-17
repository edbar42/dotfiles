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
		end, { desc = "Telescope: [S]earch [H]elp" })

		vim.keymap.set("n", "<leader>gf", function()
			builtin.git_files(ivy)
		end, { desc = "Telescope: [G]it [F]ile Search" })

		vim.keymap.set("n", "<leader>sk", function()
			builtin.keymaps(ivy)
		end, { desc = "Telescope: [S]earch [K]eymaps" })

		vim.keymap.set("n", "<leader>sf", function()
			builtin.find_files(ivy)
		end, { desc = "Telescope: [S]earch [F]iles" })

		vim.keymap.set("n", "<leader>fs", function()
			builtin.current_buffer_fuzzy_find(ivy)
		end, { desc = "Telescope: [F]uzzy [S]earch the current buffer" })

		vim.keymap.set("n", "<leader>ps", function()
			builtin.live_grep(ivy)
		end, { desc = "Telescope: [S]earch by [G]rep" })

		vim.keymap.set("n", "<leader>gw", function()
			builtin.grep_string(ivy)
		end, { desc = "Telescope: [G]rep current [W]ord" })

		vim.keymap.set("n", "<leader>rc", function()
			builtin.commands(ivy)
		end, { desc = "Telescope: [R]un [C]ommand" })

		vim.keymap.set("n", "<leader><leader>", function()
			builtin.buffers(ivy)
		end, { desc = "Telescope: [ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>ch", function()
			builtin.command_history(ivy)
		end, { desc = "Telescope: Browse [C]ommand [H]istory" })

		vim.keymap.set("n", "<leader>uu", "<cmd>Telescope undo<CR>", { desc = "Telescope: Browse undo history" })

		vim.keymap.set("n", "<leader>gc", function()
			builtin.git_commits(ivy)
		end, { desc = "Telescope: [G]it [C]ommits with diff view" })

		vim.keymap.set("n", "<leader>bgc", function()
			builtin.git_commits(ivy)
		end, { desc = "Telescope: Current [B]uffer's [G]it [C]ommits with diff view" })
	end,
}
