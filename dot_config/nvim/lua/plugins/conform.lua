return { -- Lightweight yet powerful formatter
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
				})
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			cs = { "csharpier" },
			lua = { "stylua" },
			go = { "gofumpt", "goimports" },
			javascript = { "prettier", "biome" },
			typescript = { "prettier", "biome" },
			javascriptreact = { "prettier", "biome" },
			typescriptreact = { "prettier", "biome" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			html = { "prettier", "biome" },
			json = { "prettier", "biome" },
			jsonc = { "prettier", "biome" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			astro = { "prettier", "biome" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--print-width", "80" },
			},
		},
	},
}
