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
          end
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
        require("dapui").eval(
          nil,
          { enter = true },
          { desc = "DEBUG: Evaluate expression under cursor" }
        )
      end)

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
            size = 15,                       -- height in lines (adjust to taste)
            position = "bottom",             -- "left", "right", "top", "bottom"
          },
        },
      })
    end,
  },
}
