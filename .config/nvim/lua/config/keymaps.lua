-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-g>", function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  vim.fn.setreg("+", path)
  vim.notify(path)
end, { desc = "Copy relative file path to clipboard" })

vim.keymap.set("n", "<leader>xa", function()
  local entry = {
    bufnr = vim.api.nvim_get_current_buf(),
    lnum = vim.fn.line("."),
    col = vim.fn.col("."),
    text = vim.fn.getline("."),
  }
  vim.fn.setqflist({ entry }, "a")
  vim.cmd("copen")
  vim.cmd("wincmd p")
end, { desc = "Add location to quickfix" })
