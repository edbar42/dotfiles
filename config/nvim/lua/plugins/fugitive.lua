return { -- Git wrapper for neovim
	"tpope/vim-fugitive",

	config = function()
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("vertical Git")
			vim.cmd("vertical resize 50")
		end, { desc = "Git (Fugitive) status" })

		vim.keymap.set("n", "<leader>df", vim.cmd.Gdiffsplit, { desc = "Open diffs on split window" })
		vim.keymap.set("n", "<leader>gl", function()
			vim.cmd("vertical Git --paginate log")
			vim.cmd("vertical resize 65")
		end, { desc = "Open git log on split window" })
	end,
}
