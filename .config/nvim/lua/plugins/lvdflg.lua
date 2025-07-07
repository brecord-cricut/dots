return {
  "Benjman/lvdflg.nvim",
  cond = vim.env.REPOS ~= nil,
  opts = function()
    local path = vim.env.REPOS .. "/dots"
    return vim.fn.isdirectory(path) == 1 and {
      git_dir = path,
    }
  end,
  event = "VeryLazy",
}
