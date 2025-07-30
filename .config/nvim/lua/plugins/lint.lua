return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.stdpath("config") .. "/nvim/external/markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
