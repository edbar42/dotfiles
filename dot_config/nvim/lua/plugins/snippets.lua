-- lua/plugins/luasnip.luasni
return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node
		local fmt = require("luasnip.extras.fmt").fmt

		require("luasnip.loaders.from_vscode").lazy_load()
		-- Your custom Go snippets
		ls.add_snippets("go", {
			s(
				"iferr",
				fmt(
					[[
					if err != nil {{
						return {}
					}}
					]],
					{ i(1, "err") }
				)
			),
			s(
				"iferrz",
				fmt(
					[[
					if err != nil {{
						return {}, err
					}}
					]],
					{ i(1, "nil") }
				)
			),
			s(
				"iferrx",
				fmt(
					[[
					{}{}, err := {}({})
					if err != nil {{
						return {}
					}}
					]],
					{ i(1, ""), i(2, ""), i(3, "fn"), i(4, ""), i(5, "err") }
				)
			),
		})

		-- Optional settings
		ls.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
		})
	end,
}
