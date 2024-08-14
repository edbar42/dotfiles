return { -- Git decorations on the sidebar
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup({
			signs = {
				add          = { text = '+' },
				change       = { text = '~' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
			},
			numhl = true,
		})
	end
}
