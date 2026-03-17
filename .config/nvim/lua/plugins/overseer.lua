return {
  {
    "stevearc/overseer.nvim",
    opts = {
      dap = true, -- Enable DAP integration (preLaunchTask/postDebugTask)
      task_list = {
        direction = "bottom",
        bindings = {
          ["?"] = "ShowHelp",
          ["g?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = "Open",
          ["<C-v>"] = "OpenVsplit",
          ["<C-s>"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["<C-q>"] = "OpenQuickFix",
          ["p"] = "TogglePreview",
          ["<C-l>"] = "IncreaseDetail",
          ["<C-h>"] = "DecreaseDetail",
          ["L"] = "IncreaseAllDetail",
          ["H"] = "DecreaseAllDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
          ["<C-k>"] = "ScrollOutputUp",
          ["<C-j>"] = "ScrollOutputDown",
          ["q"] = "Close",
        },
      },
      component_aliases = {
        default = {
          "on_exit_set_status",
          {
            "on_output_notify",
            delay_ms = 1000, -- Show notification after 1 second of running
            max_lines = 3, -- Show up to 3 lines of output
            output_on_complete = true, -- Show output when complete
          },
          "on_complete_notify",
          {
            "open_output",
            direction = "float",
            on_start = "always", -- Open floating window when task starts
            on_complete = "never", -- Don't reopen on complete (notification is enough)
            focus = false, -- Don't steal focus
          },
          {
            "on_complete_dispose",
            timeout = 2, -- Auto-close after 2 seconds on success
            statuses = { "SUCCESS" }, -- Only auto-close on success
          },
        },
      },
    },
  },
}