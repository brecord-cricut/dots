vim.opt.fixendofline = false
vim.opt.linebreak = true
vim.opt.spell = true
vim.opt.wrap = true

if vim.env.OPENCODE then
  vim.diagnostic.enable(false)
end
