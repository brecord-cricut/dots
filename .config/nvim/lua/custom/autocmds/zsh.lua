--[[
Autocmds to detect when files in ~/.config/zsh are updated via Neovim.
If any file in that directory is written during the session, then on Neovim exit,
attempts to source ~/.zshrc. Note: sourcing occurs in a subshell and does not affect
the current shell environment; manual sourcing may be required for changes to take effect.
]]

local zsh_config_dir = vim.fn.stdpath("config") .. "/zsh"
local zshrc = vim.fn.expand(vim.env.HOME .. "/.zshrc")
local updated_zsh_config = false
local group = vim.api.nvim_create_augroup("ZshConfigAutoSource", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = { zsh_config_dir .. "/*", zshrc },
  callback = function()
    updated_zsh_config = true
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    if updated_zsh_config then
      if vim.env.ZSH_UPDATE_TRIGGER_PATH ~= nil then
        vim.fn.system({ "touch", vim.env.ZSH_UPDATE_TRIGGER_PATH })
      else
      end
    end
  end,
})
