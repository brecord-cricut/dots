return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    enabled = vim.fn.executable("flutter") == 1,
    opts = function()
      LazyVim.safe_keymap_set("n", "<Leader>Fd", "<cmd>FlutterDebug<cr>")
      LazyVim.safe_keymap_set("n", "<Leader>Fl", function()
        vim.cmd("FlutterLogToggle")
        -- Reset DAP UI, if its open:
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
          if filetype == "dapui_scopes" then
            require("dapui").open({ reset = true })
            break
          end
        end
      end, { desc = "FlutterLogToggle" })

      -- Organize imports before save (synchronous)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.dart",
        callback = function(args)
          -- Only run if buffer is still valid and loaded
          if vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_buf_is_loaded(args.buf) then
            local params = {
              textDocument = vim.lsp.util.make_text_document_params(args.buf),
              range = {
                start = { line = 0, character = 0 },
                ["end"] = { line = vim.api.nvim_buf_line_count(args.buf), character = 0 },
              },
              context = {
                only = { "source.organizeImports" },
                diagnostics = {},
              },
            }

            local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1000)
            if result then
              for _, res in pairs(result) do
                if res.result then
                  for _, action in pairs(res.result) do
                    if action.command then
                      ---@diagnostic disable-next-line: undefined-field
                      local client = vim.lsp.get_client_by_id(res.context.client_id)
                      if client then
                        ---@diagnostic disable-next-line: invisible, param-type-mismatch
                        local cmd_result = client.request_sync("workspace/executeCommand", action.command, 1000, args.buf)
                        if cmd_result and cmd_result.err then
                          vim.notify("Error executing command: " .. vim.inspect(cmd_result.err), vim.log.levels.ERROR)
                        end
                      end
                    elseif action.edit then
                      vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                    end
                  end
                end
              end
            end
          end
        end,
      })

      local device_map = {
        Darwin = "macos",
        Windows = "windows",
        Linux = "linux",
      }
      local device = device_map[vim.uv.os_uname().sysname] or "unknown"
      return {
        debugger = { enabled = true },
        default_run_args = {
          flutter = "-d " .. device,
          dart = "-d " .. device,
        },
        lsp = {
          settings = {
            lineLength = 120,
            enableSnippets = false,
          },
        },
        root_patterns = { ".git" },
        dev_log = {
          enabled = false,
          filter = nil,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dart",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "sidlatau/neotest-dart",
    },
    opts = {
      adapters = {
        ["neotest-dart"] = {},
      },
    },
  },
}
