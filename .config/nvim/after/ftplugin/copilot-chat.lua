-- For some reason, options don't take unless they're scheduled for the future:
vim.schedule(function()
  vim.opt_local.spell = true
end)
