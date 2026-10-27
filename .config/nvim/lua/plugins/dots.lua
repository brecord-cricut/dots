-- The dots repo is all dotfiles by nature, so snacks explorer both hides its contents (leading-dot filter) and greys
-- whatever survives. Browse it like a normal project. Scoped to the repo and all of its worktrees; see also
-- $REPOS/dots/.ignore, which does the same for rg/fd-backed pickers.
local function in_dots()
  return vim.env.REPOS
    and vim.startswith(vim.fs.normalize(vim.fn.getcwd()) .. "/", vim.fs.normalize(vim.env.REPOS) .. "/dots/")
end

if not in_dots() then
  return {}
end

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          exclude = { ".git" },
          -- `item.hidden` is read in exactly one place: picker/format.lua swaps the normal Directory/File highlight for
          -- SnacksPickerPathHidden (-> NonText). Clearing it keeps per-type colors, and leaves `ignored` dimming (the
          -- useful signal) intact.
          transform = function(item)
            item.hidden = false
          end,
        },
      },
    },
  },
}
