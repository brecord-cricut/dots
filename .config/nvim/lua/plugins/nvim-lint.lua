return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    -- Create a temp config file with the rule disabled
    local config_path = vim.fn.stdpath("cache") .. "/markdownlint.json"
    local config_file = io.open(config_path, "w")
    if config_file then
      config_file:write('{"MD013": false}')
      config_file:close()
    end
    local markdownlint = require("lint").linters["markdownlint-cli2"]
    markdownlint.args = { "--config", config_path, "--" }
    return opts
  end,
}
