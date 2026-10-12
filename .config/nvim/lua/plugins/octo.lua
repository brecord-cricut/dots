return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    opts = {
      picker = "snacks",
      -- Right side of the diff uses the real file on disk, so LSP attaches.
      -- Requires being on the PR branch; Octo offers to check it out.
      use_local_fs = true,
      enable_builtin = true,
      suppress_missing_scope = {
        -- `gh` token lacks `project` scope; silences the startup warning
        projects_v2 = true,
      },
    },
    keys = {
      { "<leader>goa", "<cmd>Octo actions<cr>", desc = "Octo Actions" },
      { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>goP", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
      { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>gor", "<cmd>Octo review start<cr>", desc = "Start Review" },
      { "<leader>goR", "<cmd>Octo review resume<cr>", desc = "Resume Review" },
      { "<leader>gos", "<cmd>Octo review submit<cr>", desc = "Submit Review" },
      { "<leader>god", "<cmd>Octo review discard<cr>", desc = "Discard Review" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>go", group = "octo", icon = "" },
      },
    },
  },
}
