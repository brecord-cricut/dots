--[[
This file sets up Neovim autocommands to detect modifications to Zsh
configuration files. Specifically, any files within the directory specified by
`ZDOTDIR` and the `~/.zshenv` file. If changes are made to these files during a
Neovim session, a file at the path defined by the `ZSH_STALE_PATH` environment
variable will be created upon exit, signaling that the Zsh configuration has
changed. If the Zsh configuration is edited using the `zshc` function, the
configuration will automatically be re-sourced upon exiting Neovim.
]]

local updated_zsh_config = false
local group = vim.api.nvim_create_augroup("ZshConfigAutoSource", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = { vim.env.ZDOTDIR .. "/*", vim.fn.expand(vim.env.HOME .. "/.zshenv") },
  callback = function()
    updated_zsh_config = true
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    if updated_zsh_config then
      if vim.env.ZSH_STALE_PATH ~= nil then
        vim.system({ "touch", vim.env.ZSH_STALE_PATH })
      end
    end
  end,
})
