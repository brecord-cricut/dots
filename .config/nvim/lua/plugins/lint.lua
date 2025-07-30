return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", os.getenv("XDG_CONFIG_HOME") .. "/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
