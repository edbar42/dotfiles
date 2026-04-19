return { -- Performant, batteries-included completion plugin for Neovim
	"Saghen/blink.cmp",
	version = "v0.*",
	dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
	opts = {
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
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		},
	},
}
