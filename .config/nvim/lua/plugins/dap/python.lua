return function(_, config)
  print(vim.inspect(config))
  local opts = {
    args = { "-m", "debugpy.adapter" },
  }
  return vim.tbl_extend("force", require("mason-nvim-dap.mappings.adapters.python"), opts)
end
