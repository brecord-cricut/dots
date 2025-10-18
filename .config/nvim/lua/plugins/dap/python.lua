return function(_, _)
  local opts = {
    args = { "-m", "debugpy.adapter" },
  }
  return vim.tbl_extend("force", require("mason-nvim-dap.mappings.adapters.python"), opts)
end
