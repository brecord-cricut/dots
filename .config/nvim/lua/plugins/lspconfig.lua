return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      bashls = { filetypes = { "sh", "zsh" } },
    },
  },
  keys = {
    { "<Leader>cL", require("custom.lsp").lsp_clients_popup, desc = "Show Client" },
  },
}
