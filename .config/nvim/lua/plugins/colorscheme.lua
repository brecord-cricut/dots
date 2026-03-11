return {
  priority = 100,
  { "catppuccin/nvim", event = "VeryLazy" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "folke/tokyonight.nvim", event = "VeryLazy" },
  { "navarasu/onedark.nvim", event = "VeryLazy" },
  { "projekt0n/github-nvim-theme", event = "VeryLazy" },
  { "rebelot/kanagawa.nvim", event = "VeryLazy" },
  {
    "ayu-theme/ayu-vim",
    event = "VeryLazy",
    init = function()
      vim.g.ayucolor = "mirage" -- Options: "light", "mirage", "dark"
    end,
  },
  { "roerohan/orng.nvim", event = "VeryLazy" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "orng",
    },
  },
}
