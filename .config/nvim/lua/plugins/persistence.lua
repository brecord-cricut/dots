return {
  "folke/persistence.nvim",
  init = function()
    local load = require("persistence").load
    vim.api.nvim_create_user_command("PersistenceLoad", load,
      {
        desc = "Restore last session",
      })
  end,
  opts = {},
}
