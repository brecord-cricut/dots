return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Add gutter mode indicator to lualine_x
    table.insert(opts.sections.lualine_x, 1, {
      function()
        local ok, coverage_signs = pcall(require, "coverage.signs")
        if ok and coverage_signs.is_enabled() then
          return "󰄬 Coverage"
        else
          return "󰊢 Git"
        end
      end,
      cond = function()
        -- Only show in git repositories
        return vim.b.gitsigns_status_dict ~= nil
      end,
      color = function()
        local ok, coverage_signs = pcall(require, "coverage.signs")
        if ok and coverage_signs.is_enabled() then
          return { fg = "#C3E88D" } -- Green for coverage
        else
          return { fg = "#82AAFF" } -- Blue for git
        end
      end,
    })

    return opts
  end,
}

