return { -- Undo history visualizer
	"mbbill/undotree",

	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		vim.g.undotree_WindowLayout = 4
	end
}
