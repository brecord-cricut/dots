-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local config_dir = vim.fn.stdpath("config") .. "/lua/custom/plugins"
if vim.fn.isdirectory(config_dir) == 1 then
  for _, file in ipairs(vim.fn.readdir(config_dir)) do
    if file:sub(-4) == ".lua" then
      local ok, err = pcall(require, "custom.plugins." .. file:sub(1, -5))
      if not ok then
        vim.notify("Error loading plugin: " .. file .. "\n" .. err, vim.log.levels.ERROR)
      end
    end
  end
end
