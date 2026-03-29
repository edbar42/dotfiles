return { -- A better annotation generator
	"danymat/neogen",
	dependencies = { "L3MON4D3/LuaSnip" },
	opts = {
		snippet_engine = "luasnip",
		languages = {
			cs = { template = { annotation_convention = "xmldoc" } },
			typescript = { template = { annotation_convention = "tsdoc" } },
			typescriptreact = { template = { annotation_convention = "tsdoc" } },
			go = { template = { annotation_convention = "godoc" } },
		},
	},
	keys = {
		{ "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Neogen: function doc" },
		{ "<leader>nc", function() require("neogen").generate({ type = "class" }) end, desc = "Neogen: class doc" },
		{ "<leader>nt", function() require("neogen").generate({ type = "type" }) end, desc = "Neogen: type doc" },
		{ "<leader>ni", function() require("neogen").generate({ type = "file" }) end, desc = "Neogen: file doc" },
	},
}
