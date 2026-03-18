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
      local dap = require "dap"
      local ui = require "dapui"

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

      -- C Sharp debugging
      local mason_path = vim.fn.stdpath("data") ..
          "/mason/packages/netcoredbg/netcoredbg"

      local netcoredbg_adapter = {
        type = "executable",
        command = mason_path,
        args = { "--interpreter=vscode" },
      }

      dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
      dap.adapters.coreclr = netcoredbg_adapter    -- needed for unit test debugging

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "LAUNCH directly from nvim",
          request = "launch",
          program = function()
            return require("nvim-dap-dotnet").build_dll_path()
          end,
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

      vim.keymap.set(
        "n",
        "<space>b",
        dap.toggle_breakpoint,
        { desc = "DEBUG: Toggle breakpoint" }
      )

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

      vim.keymap.set(
        "n",
        "<F1>",
        dap.continue,
        { desc = "DEBUG: Continue execution" }
      )
      vim.keymap.set(
        "n",
        "<F2>",
        dap.step_into,
        { desc = "DEBUG: Step into" }
      )
      vim.keymap.set(
        "n",
        "<F3>",
        dap.step_over,
        { desc = "DEBUG: Step over" }
      )
      vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DEBUG: Step out" })
      vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DEBUG: Step back" })
      vim.keymap.set(
        "n",
        "<F13>",
        dap.restart,
        { desc = "DEBUG: Restart execution" }
      )

      -- Signs
      vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",         linehl = "",           numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "",           numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected",  { text = "●", texthl = "DapBreakpointRejected",  linehl = "",           numhl = "" })
      vim.fn.sign_define("DapLogPoint",            { text = "◆", texthl = "DapLogPoint",            linehl = "",           numhl = "" })
      vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })

      vim.api.nvim_set_hl(0, "DapBreakpoint",         { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition",{ fg = "#f5a623" })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#555555" })
      vim.api.nvim_set_hl(0, "DapLogPoint",           { fg = "#61afef" })
      vim.api.nvim_set_hl(0, "DapStopped",            { fg = "#98c379" })
      vim.api.nvim_set_hl(0, "DapStoppedLine",        { bg = "#2a3021" })

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
            size = 15,                       -- height in lines
            position = "bottom",
          },
          {
            elements = {
              { id = "repl", size = 1.0 }, -- 100% of this panel is REPL
            },
            size = 50,                     -- width in columns
            position = "right",
          },
        },
      })
    end,
  },
}
