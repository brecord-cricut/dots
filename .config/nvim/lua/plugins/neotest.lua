return {
  "nvim-neotest/neotest",
  dependencies = {
    "alfaix/neotest-gtest",
    "xieyonn/spinner.nvim",
  },
  opts = function()
    -- Get spinner pattern frames
    local spinner_patterns = require("spinner.pattern")
    local pattern = spinner_patterns.dotsCircle

    return {
      adapters = {
        ["neotest-dart"] = {},
        ["neotest-gtest"] = {},
      },
      -- Icons for test statuses and UI elements
      icons = {
        -- Status icons
        passed = "󰗠",
        failed = "󰅙",
        running = "󰑐",
        skipped = "󰍷",
        unknown = "󰞋",
        -- Tree structure icons
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        -- Other icons
        notify = "󰍡",
        test = "󰙨",
        running_animated = pattern.frames,
        watching = "󰈈",
      },
      -- Floating window configuration
      floating = {
        border = "rounded",
        max_height = 0.8,
        max_width = 0.8,
        options = {
          winblend = 0,
        },
      },
      -- Summary window configuration
      summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
        count = true,
        open = "botright vsplit | vertical resize 50",
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          help = "?",
          jumpto = "o",
          mark = "m",
          next_failed = "J",
          next_sibling = ">",
          output = "i",
          parent = "P",
          prev_failed = "K",
          prev_sibling = "<",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
          watch = "w",
        },
      },
      -- Output configuration
      output = {
        enabled = true,
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      -- Status configuration
      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },
      -- Quickfix configuration
      quickfix = {
        enabled = true,
        open = false,
      },
      -- Diagnostic configuration
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      -- Strategy configuration
      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },
    }
  end,
}
