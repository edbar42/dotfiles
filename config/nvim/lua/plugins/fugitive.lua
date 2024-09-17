return { -- Git wrapper for neovim
	"tpope/vim-fugitive",

	config = function()
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("vertical Git")
		end, { desc = "Git (Fugitive) status" })

		vim.keymap.set("n", "<leader>df", vim.cmd.Gdiffsplit, { desc = "Open diffs on split window" })
		vim.keymap.set("n", "<leader>gl", function()
			vim.cmd("Git --paginate log")
		end, { desc = "Open diffs on split window" })
	end,
}
