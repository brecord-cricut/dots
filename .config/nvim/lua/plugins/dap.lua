return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      -- UI
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end

          -- Auto-reset DAP UI on Neovim resize (for tiling WMs)
          local resize_timer = nil
          vim.api.nvim_create_autocmd("VimResized", {
            group = vim.api.nvim_create_augroup("dapui_resize", { clear = true }),
            callback = function()
              -- Debounce: cancel pending reset if another resize comes in
              if resize_timer then
                vim.fn.timer_stop(resize_timer)
              end
              resize_timer = vim.fn.timer_start(100, function()
                resize_timer = nil
                -- Only reset if there's an active debug session and DAP UI is open
                if dap.session() then
                  -- Check if any dapui window is visible
                  for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                    if ft:match("^dapui_") then
                      dapui.open({ reset = true })
                      break
                    end
                  end
                end
              end)
            end,
          })
        end,
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
      local dapui = require("dapui")

      -- Exception breakpoint toggle state
      local exception_bp_enabled = false

      local function toggle_exception_breakpoints()
        if not dap.session() then
          vim.notify("No active debug session", vim.log.levels.WARN)
          return
        end

        exception_bp_enabled = not exception_bp_enabled

        if exception_bp_enabled then
          -- Enable: use adapter default exception breakpoints
          dap.set_exception_breakpoints("default")
          vim.notify("🔴 Exception breakpoints ON", vim.log.levels.INFO)
        else
          -- Disable: don't break on any exceptions
          dap.set_exception_breakpoints({})
          vim.notify("⚪ Exception breakpoints OFF", vim.log.levels.INFO)
        end
      end

      -- Keymaps
      local map = vim.keymap.set

      -- Breakpoints
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
      map("n", "<leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = "Log Point" })

      -- Execution
      map("n", "<leader>dc", function()
        if dap.session() then
          dap.continue()
        elseif vim.bo.filetype == "dart" then
          vim.cmd("FlutterDebug")
        else
          dap.continue()
        end
      end, { desc = "Continue" })
      map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
      map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      map("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
      map("n", "<leader>dj", dap.down, { desc = "Down" })
      map("n", "<leader>dk", dap.up, { desc = "Up" })
      map("n", "<leader>dp", dap.pause, { desc = "Pause" })

      -- Session
      map("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
      map("n", "<leader>ds", dap.session, { desc = "Session" })
      map("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
      map("n", "<leader>dR", dap.restart, { desc = "Restart" })

      -- UI
      map("n", "<leader>du", function() dapui.toggle({}) end, { desc = "Toggle DAP UI" })
      map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })

      -- Exception breakpoints
      map("n", "<leader>dx", toggle_exception_breakpoints, { desc = "Toggle Exception Breakpoints" })
      map("n", "<leader>ux", toggle_exception_breakpoints, { desc = "Toggle Exception Breakpoints" })

      -- Widgets
      map("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

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
