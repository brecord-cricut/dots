return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 0,
      virt_text_pos = "right_align",
    },
  },
  keys = {
    {
      "<leader>uB",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Toggle Current Line Blame",
    },
  },
}
