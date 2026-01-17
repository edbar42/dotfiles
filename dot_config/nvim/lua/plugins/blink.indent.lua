return { -- Performant indent guides for NeoVim
	"saghen/blink.indent",
	config = function()
		require("blink.indent").setup({
			blocked = {
				buftypes = { include_defaults = true },
				filetypes = { include_defaults = true },
			},
			mappings = {
				border = "both",
				object_scope = "ii",
				object_scope_with_border = "ai",
				goto_top = "[i",
				goto_bottom = "]i",
			},
			static = {
				enabled = true,
				char = "▎",
				whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
				priority = 1,
				-- specify multiple highlights here for rainbow-style indent guides
				-- highlights = { 'BlinkIndentRed', 'BlinkIndentOrange', 'BlinkIndentYellow', 'BlinkIndentGreen', 'BlinkIndentViolet', 'BlinkIndentCyan' },
				highlights = { "BlinkIndent" },
			},
			scope = {
				enabled = true,
				char = "▎",
				priority = 1000,
				-- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
				-- highlights = { 'BlinkIndentScope' },
				-- optionally add: 'BlinkIndentRed', 'BlinkIndentCyan', 'BlinkIndentYellow', 'BlinkIndentGreen'
				highlights = { "BlinkIndentOrange", "BlinkIndentViolet", "BlinkIndentBlue" },
				-- enable to show underlines on the line above the current scope
				underline = {
					enabled = false,
					-- optionally add: 'BlinkIndentRedUnderline', 'BlinkIndentCyanUnderline', 'BlinkIndentYellowUnderline', 'BlinkIndentGreenUnderline'
					highlights = {
						"BlinkIndentOrangeUnderline",
						"BlinkIndentVioletUnderline",
						"BlinkIndentBlueUnderline",
					},
				},
			},
		})
	end,
}
