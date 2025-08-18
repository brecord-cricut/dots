local cwd = vim.fn.getcwd()
local home = vim.env.HOME
if not vim.startswith(cwd, home) then
  return
end

local path = cwd
local configs = {}

while true do
  local dir = path .. "/.nvim"
  local init = dir .. "/init.lua"

  if vim.fn.isdirectory(dir) == 1 and vim.fn.filereadable(init) == 1 then
    table.insert(configs, 1, init)
  end

  if path == home then
    break
  end
  path = vim.fs.dirname(path)
  if #path < #home then
    break
  end
end

for _, config in ipairs(configs) do
  vim.cmd("luafile " .. vim.fn.fnameescape(config))
end
