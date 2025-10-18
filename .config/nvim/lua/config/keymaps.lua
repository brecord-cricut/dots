-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open DevOps links with `gx`:
if vim.env.DEVOPS_URL ~= nil then
  vim.keymap.set("n", "gx", function()
    local id = vim.fn.expand("<cWORD>"):match("AB#(%d+)")
    if id then
      local opts = {
        cmd = "xdg-open",
        url = vim.env.DEVOPS_URL .. id,
      }
      if vim.fn.has("mac") == 1 then
        opts.cmd = "open"
      end
      vim.fn.jobstart(opts, { detach = true })
    else
      -- fallback to default gx:
      vim.api.nvim_feedkeys("gx", "n", true)
    end
  end, { noremap = true, silent = true })
end
