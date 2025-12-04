--[[
This file sets up Neovim autocommands to modify the quickfix list
]]

-- Deletes qflist entry from the collection
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    local function delete_qf_entries(start_line, end_line)
      local qf_list = vim.fn.getqflist()
      if #qf_list == 0 then
        return
      end

      start_line = math.max(1, math.min(start_line or vim.fn.line("."), #qf_list))
      end_line = math.max(1, math.min(end_line or start_line, #qf_list))

      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end

      local count = end_line - start_line + 1

      -- Remove from bottom to top so indices stay valid
      for i = end_line, start_line, -1 do
        table.remove(qf_list, i)
      end

      vim.fn.setqflist(qf_list, "r")

      -- Place cursor on the line that follows the deleted block
      local new_line = start_line
      if new_line > #qf_list then
        new_line = #qf_list
      end
      if new_line >= 1 then
        vim.api.nvim_win_set_cursor(0, { new_line, 0 })
      end

      -- Exit visual mode if we were in it
      vim.cmd("normal! ")

      -- Optional nice feedback
      if count > 1 then
        vim.notify(string.format("Deleted %d quickfix entr%s", count, count == 1 and "y" or "ies"))
      end
    end

    --------------------------------------------------------------------
    -- 1. dd → delete current line (normal mode)
    --------------------------------------------------------------------
    vim.keymap.set("n", "dd", function()
      delete_qf_entries(vim.fn.line("."), vim.fn.line("."))
    end, { buffer = true, desc = "Delete quickfix entry under cursor" })

    --------------------------------------------------------------------
    -- 2. d{motion} → operator-pending mode (normal mode)
    --------------------------------------------------------------------
    local function qf_delete_operator()
      -- This function is called twice:
      --   1. when you press `d`  → we record the start position
      --   2. after the motion   → we get the end position and delete
      local mode = vim.fn.mode(true) -- "no", "v", etc.

      if mode == "no" or mode == "n" then
        -- First press of `d`
        vim.o.operatorfunc = "v:lua.qf_delete_operator_func"
        return "g@"
      else
        -- Motion completed → delete the range
        local start_line = vim.fn.line("'[")
        local end_line = vim.fn.line("']")
        delete_qf_entries(start_line, end_line)
      end
    end

    -- Expose the actual deletion function to VimL
    _G.qf_delete_operator_func = function()
      local start_line = vim.fn.line("'[")
      local end_line = vim.fn.line("']")
      delete_qf_entries(start_line, end_line)
    end

    vim.keymap.set(
      "n",
      "d",
      qf_delete_operator,
      { buffer = true, expr = true, desc = "Delete quickfix entries (motion)" }
    )

    --------------------------------------------------------------------
    -- 3. Visual mode → d or dd
    --------------------------------------------------------------------
    vim.keymap.set("x", "d", function()
      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      delete_qf_entries(start_line, end_line)
    end, { buffer = true, desc = "Delete selected quickfix entries" })

    -- Optional: also allow dd in visual mode (like normal mode)
    vim.keymap.set("x", "dd", function()
      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      delete_qf_entries(start_line, end_line)
    end, { buffer = true, desc = "Delete selected quickfix entries" })
  end,
})
