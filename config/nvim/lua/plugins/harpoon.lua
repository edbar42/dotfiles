return { -- Getting you where you want with the fewest keystrokes
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		require("harpoon").setup({})

		local harpoon = require("harpoon")

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add buffer to Harpoon UI" })

		vim.keymap.set("n", "<leader>e", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Show Harpoon UI" })

		-- Set <space>{1..5} as shortcuts for available files
		for _, index in ipairs({ 1, 2, 3, 4, 5 }) do
			vim.keymap.set("n", string.format("<space>%d", index), function()
				harpoon:list():select(index)
			end, { desc = string.format("Open Harpoon buffer #%d", index) })
		end
	end,
}
