return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {
      config = {
        os = {
          -- Override the edit command to use :edit instead of :tabedit
          edit = '[ -z "$NVIM" ] && nvim -- {{filename}} || nvim --server "$NVIM" --remote-send "q<cmd>edit {{filename}}<CR>"',
        },
      },
    },
  },
}
