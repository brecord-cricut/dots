return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        list = {
          keys = {
            ["/"] = false, -- Disables custom fuzzy search
          },
        },
      },
    },
  },
}
