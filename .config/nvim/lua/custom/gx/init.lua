---@class GxPattern
---@field pattern string Lua pattern used to find an override match. May contain a capture; captured value is passed to `url`.
---@field url fun(capture: string): string|nil Function that receives the capture group and returns a URL. Return `nil` or an empty string to signal failure.
---
---@class GxConfig
---@field patterns GxPattern[]

local M = {}

M.config = {
  patterns = {},
}

local function get_open_cmd()
  local os_name = vim.uv.os_uname().sysname
  if os_name == "Darwin" then
    return "open"
  elseif os_name == "Windows_NT" then
    return { "cmd", "/c", "start", "" }
  else
    return "xdg-open"
  end
end

local function open_url(url)
  local open_cmd = get_open_cmd()
  local cmd

  if type(open_cmd) == "table" then
    cmd = vim.fn.tbl_flatten({ open_cmd, url })
  else
    cmd = { open_cmd, url }
  end

  vim.fn.jobstart(cmd, { detach = true })
end

function M.open_custom_url()
  local word = vim.fn.expand("<cWORD>")

  for _, pattern_def in ipairs(M.config.patterns) do
    local capture = word:match(pattern_def.pattern)
    if capture and pattern_def.url then
      local url = pattern_def.url(capture)
      if not url or url == "" then
        return
      end
      vim.notify("Opening: " .. url, vim.log.levels.TRACE)
      open_url(url)
      return
    end
  end

  vim.api.nvim_feedkeys("gx", "n", false)
end

---@param opts GxConfig
function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
  vim.keymap.set("n", "gx", M.open_custom_url, { noremap = true, silent = true })
end

return M
