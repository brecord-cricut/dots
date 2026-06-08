return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      -- UI
      {
        "igorlfs/nvim-dap-view",
        opts = {
          winbar = {
            sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "console", "repl" },
            default_section = "repl",
          },
          auto_toggle = "open_term",
        },
        keys = {
          {
            "<leader>d3",
            function()
              require("dap-view").hover()
            end,
            desc = "Dap View Hover",
          },
          {
            "<leader>du",
            function()
              require("dap-view").toggle()
            end,
            desc = "Toggle DAP view",
          },
          {
            "<leader>dw",
            function()
              require("dap-view").watch()
            end,
            desc = "DAP View Watch",
          },
        },
      },

      -- Virtual text
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- Mason integration for installing debug adapters
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          ensure_installed = {
            "debugpy", -- Python
            "codelldb", -- C/C++/Rust
          },
        },
      },

      -- Python
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          -- Use debugpy from mason
          local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
          require("dap-python").setup(debugpy_path)
        end,
      },
    },

    config = function()
      local dap = require("dap")
      -- local dapui = require("dapui")

      -- Exception breakpoint toggle state
      local break_on_exception = true

      local function toggle_exception_breakpoints()
        if not dap.session() then
          vim.notify("No active debug session", vim.log.levels.WARN)
          return
        end

        break_on_exception = not break_on_exception

        if break_on_exception then
          -- Enable: use adapter default exception breakpoints
          dap.set_exception_breakpoints("default")
          vim.notify("🔴 Break on exceptions ON", vim.log.levels.INFO)
        else
          -- Disable: don't break on any exceptions
          dap.set_exception_breakpoints({})
          vim.notify("⚪ Break on exceptions OFF", vim.log.levels.INFO)
        end
      end

      -- Breakpoints
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dl", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Log Point" })

      -- Execution
      vim.keymap.set("n", "<leader>dc", function()
        if dap.session() then
          dap.continue()
        elseif vim.bo.filetype == "dart" then
          vim.cmd("FlutterDebug")
        else
          dap.continue()
        end
      end, { desc = "Continue" })
      vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Down" })
      vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Up" })
      vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })

      -- Session
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
      vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Session" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<leader>dR", dap.restart, { desc = "Restart" })

      -- -- UI
      -- vim.keymap.set("n", "<leader>du", function()
      --   dapui.toggle({})
      -- end, { desc = "Toggle DAP UI" })
      -- vim.keymap.set("n", "<leader>dU", function()
      --   dapui.open({ reset = true })
      -- end, { desc = "Reset DAP UI" })
      -- vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })

      -- Exception breakpoints
      vim.keymap.set("n", "<leader>dx", toggle_exception_breakpoints, { desc = "Toggle Exception Breakpoints" })
      vim.keymap.set("n", "<leader>ux", toggle_exception_breakpoints, { desc = "Toggle Exception Breakpoints" })

      -- -- Widgets
      -- vim.keymap.set("n", "<leader>dw", function()
      --   require("dap.ui.widgets").hover()
      -- end, { desc = "Widgets" })

      -- Signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "DapStoppedLine", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError", linehl = "", numhl = "" })

      -- Highlight for stopped line
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- C/C++ configuration using codelldb
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }
      -- Alias for compatibility with launch configs that use "lldb"
      dap.adapters.lldb = dap.adapters.codelldb

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      -- Dart/Flutter is handled by flutter-tools.nvim
    end,
  },

  -- Add which-key group
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>d", group = "debug" },
      },
    },
  },
}
