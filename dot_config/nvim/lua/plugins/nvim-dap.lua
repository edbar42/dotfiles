return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"nvim-lua/plenary.nvim", -- Required by your custom dll picker
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()
			require("nvim-dap-virtual-text").setup({
				display_callback = function(variable, _, _, _, _)
					if #variable.value > 50 then
						return " = " .. string.sub(variable.value, 1, 50) .. "..."
					end
					return " = " .. variable.value
				end,
			})

			-- Go debugging
			dap.adapters.go = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- Rust debugging
			local codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
			if vim.fn.executable(codelldb) == 1 then
				dap.adapters.codelldb = {
					type = "executable",
					command = codelldb,
				}

				dap.configurations.rust = {
					{
						name = "Rust: Launch executable",
						type = "codelldb",
						request = "launch",
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
						end,
					},
				}
			end

			---------- .NET / C# debugging ----------

			local function find_project_root_by_csproj(start_path)
				local Path = require("plenary.path")
				local path = Path:new(start_path)

				while true do
					local csproj_files = vim.fn.glob(path:absolute() .. "/*.csproj", false, true)
					if #csproj_files > 0 then
						return path:absolute()
					end

					local parent = path:parent()
					if parent:absolute() == path:absolute() then
						return nil
					end

					path = parent
				end
			end

			local function get_highest_net_folder(bin_debug_path)
				local dirs = vim.fn.glob(bin_debug_path .. "/net*", false, true)

				if dirs == 0 then
					error("No netX.Y folders found in " .. bin_debug_path)
				end

				table.sort(dirs, function(a, b)
					local ver_a = tonumber(a:match("net(%d+)%.%d+"))
					local ver_b = tonumber(b:match("net(%d+)%.%d+"))
					return ver_a > ver_b
				end)

				return dirs[1]
			end

			local function build_dll_path()
				local current_file = vim.api.nvim_buf_get_name(0)
				local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

				local project_root = find_project_root_by_csproj(current_dir)
				if not project_root then
					error("Could not find project root (no .csproj found)")
				end

				local csproj_files = vim.fn.glob(project_root .. "/*.csproj", false, true)
				if #csproj_files == 0 then
					error("No .csproj file found in project root")
				end

				local project_name = vim.fn.fnamemodify(csproj_files[1], ":t:r")
				local bin_debug_path = project_root .. "/bin/Debug"
				local highest_net_folder = get_highest_net_folder(bin_debug_path)
				local dll_path = highest_net_folder .. "/" .. project_name .. ".dll"

				print("Launching: " .. dll_path)
				return dll_path
			end

			local mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

			local netcoredbg_adapter = {
				type = "executable",
				command = mason_path,
				args = { "--interpreter=vscode" },
			}

			dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
			dap.adapters.coreclr = netcoredbg_adapter -- needed for unit test debugging

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "LAUNCH directly from nvim",
					request = "launch",
					program = build_dll_path,
					justMyCode = false,
				},
				{
					type = "coreclr",
					name = "Attach to running dotnet process",
					request = "attach",
					processId = require("dap.utils").pick_process,
					justMyCode = false,
				},
			}

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "DEBUG: Toggle breakpoint" })

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "DEBUG: Evaluate expression under cursor" })

			-- Conditional breakpoint
			vim.keymap.set("n", "<space>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "DEBUG: Set conditional breakpoint" })

			-- Toggle UI panels
			vim.keymap.set("n", "<space>du", ui.toggle, { desc = "DEBUG: Toggle UI" })
			vim.keymap.set("n", "<space>de", function()
				ui.toggle({ layout = 2 })
			end, { desc = "DEBUG: Toggle REPL" })

			vim.keymap.set("n", "<F1>", dap.continue, { desc = "DEBUG: Continue execution" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DEBUG: Step into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DEBUG: Step over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DEBUG: Step out" })
			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DEBUG: Step back" })
			vim.keymap.set("n", "<F13>", dap.restart, { desc = "DEBUG: Restart execution" })

			-- Signs
			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "●", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", {
				text = "◆",
				texthl = "DapLogPoint",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" }
			)

			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
			vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f5a623" })
			vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#555555" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
			vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2a3021" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end

			-- more minimal ui
			ui.setup({
				expand_lines = true,
				controls = { enabled = false }, -- no extra play/step buttons
				floating = { border = "rounded" },
				-- Set dapui window
				render = {
					max_type_length = 60,
					max_value_lines = 200,
				},
				-- Only one layout: just the "scopes" (variables) list at the bottom
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
						},
						size = 15, -- height in lines
						position = "bottom",
					},
					{
						elements = {
							{ id = "repl", size = 1.0 }, -- 100% of this panel is REPL
						},
						size = 50, -- width in columns
						position = "right",
					},
				},
			})
		end,
	},
}
