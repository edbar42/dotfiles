return { -- Performant, batteries-included completion plugin for Neovim
	"Saghen/blink.cmp",
	version = "v0.*",
	dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
	opts = function()
		local ls = require("luasnip")

		return {
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			snippets = { preset = "luasnip" },
			sources = { default = { "lsp", "path", "buffer", "snippets" } },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				ghost_text = { enabled = false },
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
				},
			},
			signature = { enabled = true },
			keymap = {
				preset = "none",
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-n>"] = {
					"select_next",
					function(fallback)
						if ls.expand_or_locally_jumpable() then
							ls.expand_or_jump()
						else
							fallback()
						end
					end,
				},
				["<C-p>"] = {
					"select_prev",
					function(fallback)
						if ls.jumpable(-1) then
							ls.jump(-1)
						else
							fallback()
						end
					end,
				},
			},
		}
	end,
}
