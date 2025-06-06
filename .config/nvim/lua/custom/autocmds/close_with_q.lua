--[[
Autocmds for filetypes that should be closed or quit with <q>.
Buffers for these filetypes are set as unlisted to avoid cluttering buffer lists.
]]

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- quit some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("quit_with_q"),
  pattern = {
    "gitcommit",
    "gitrebase",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("quit")
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit Vim",
      })
    end)
  end,
})

-- close some filetypes with <q>, extends LazyVim's existing buffer list
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "dap-float",
    "log",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})
