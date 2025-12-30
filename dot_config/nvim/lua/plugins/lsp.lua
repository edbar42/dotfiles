return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},

		config = function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 4,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "if_many",
				},
			})

			-- Diagnostic signs in the gutter
			local signs = {
				Error = "",
				Warn = "",
				Hint = "󱧡",
				Info = "",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- LSP handlers with borders
			local handlers = {
				["textDocument/hover"] = vim.lsp.handlers.hover,
				["textDocument/signatureHelp"] = vim.lsp.handlers.signature_help,
			}
			for k, v in pairs(handlers) do
				vim.lsp.handlers[k] = vim.lsp.with(v, { border = "rounded" })
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, {
							buffer = event.buf,
							desc = "LSP: " .. desc,
						})
					end

					-- Navigation
					map("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
					map("gr", require("telescope.builtin").lsp_references, "Goto references")
					map("gI", require("telescope.builtin").lsp_implementations, "Goto implementation")
					map("gD", vim.lsp.buf.declaration, "Goto declaration")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type definition")

					-- Symbols
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")

					-- Actions
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
					map("K", vim.lsp.buf.hover, "Hover documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")

					-- Diagnostics
					map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("<leader>e", vim.diagnostic.open_float, "Show diagnostic")
					map("<leader>q", vim.diagnostic.setloclist, "Diagnostic quickfix")

					-- Workspace
					map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
					map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
					map("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "List workspace folders")

					-- Document highlight
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", {
								clear = true,
							}),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end

					-- Inlay hints (if supported)
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "Toggle inlay hints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
				csharp_ls = {
					cmd = { "csharp-ls" },
					cmd_env = {
						DOTNET_ROOT = vim.fn.expand("~/.local/share/mise/installs/dotnet/10.0.101"),
					},
					handlers = {
						["textDocument/definition"] = require("csharpls_extended").handler,
						["textDocument/typeDefinition"] = require("csharpls_extended").handler,
					},
				},
				gopls = {
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
								shadow = true,
							},
							staticcheck = true,
							gofumpt = true,
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								disable = { "missing-fields" },
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
							},
							telemetry = { enable = false },
							hint = {
								enable = true,
							},
						},
					},
				},
				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									maxLineLength = 88,
								},
							},
						},
					},
				},
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
			}

			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"gofumpt",
				"prettier",
			})
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
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
				lua = { "stylua" },
				go = { "gofumpt", "goimports" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				astro = { "prettier" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--print-width", "80" },
				},
			},
		},
	},
}
