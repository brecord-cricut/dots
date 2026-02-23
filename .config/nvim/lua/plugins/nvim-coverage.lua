-- Smart toggle function that loads coverage if not already loaded
-- Also toggles gitsigns to avoid gutter conflicts
local smart_coverage_toggle = function()
  local coverage = require("coverage")
  local report = require("coverage.report")
  local signs = require("coverage.signs")

  -- Safely try to load gitsigns
  local has_gitsigns, gitsigns = pcall(require, "gitsigns")

  -- Check if coverage data is cached
  if not report.is_cached() then
    -- No coverage loaded yet, load it
    coverage.load(true)
    -- Disable gitsigns when showing coverage
    if has_gitsigns then
      gitsigns.toggle_signs(false)
    end
  else
    -- Coverage is loaded, toggle it
    if signs.is_enabled() then
      -- Coverage is currently shown, hide it and show gitsigns
      coverage.toggle()
      if has_gitsigns then
        gitsigns.toggle_signs(true)
      end
    else
      -- Coverage is hidden, show it and hide gitsigns
      coverage.toggle()
      if has_gitsigns then
        gitsigns.toggle_signs(false)
      end
    end
  end
end

return {
  "andythigpen/nvim-coverage",
  config = function()
    require("coverage").setup({
      auto_reload = true,
      lang = {
        cpp = {
          coverage_file = "lcov.info",
        },
        dart = {
          coverage_file = "coverage/lcov.info",
        },
      },
    })

    -- Auto-apply coverage signs to new buffers if coverage is already loaded
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("CoverageAutoShow", { clear = true }),
      callback = function(args)
        -- Only apply to normal file buffers
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
        if buftype ~= "" then
          return
        end

        local report = require("coverage.report")
        local signs = require("coverage.signs")

        -- If coverage data is cached and signs are enabled, ensure they show in new buffers
        if report.is_cached() and signs.is_enabled() then
          vim.defer_fn(function()
            -- Make sure we're still in the same buffer
            if vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_get_current_buf() == args.buf then
              -- Force reload to apply coverage to this buffer
              require("coverage").load(true)
              vim.notify("Hit")
            end
          end, 100)
        end
      end,
    })
  end,
  -- stylua: ignore
  keys = {
    { "<leader>tc", "", desc = "+coverage" },
    { "<leader>tcc", function() require("coverage").load(true) end, desc = "Load Coverage" },
    { "<leader>uv",  smart_coverage_toggle, desc = "Toggle Coverage" },
    { "<leader>tcs", function() require("coverage").summary() end, desc = "Coverage Summary" },
    { "<leader>tch", function() require("coverage").hide() end, desc = "Hide Coverage" },
    { "<leader>tcw", function() require("coverage").show() end, desc = "Show Coverage" },
    { "<leader>tcC", function() require("coverage").clear() end, desc = "Clear Coverage" },
    { "]c", function() require("coverage").jump_next("uncovered") end, desc = "Next Uncovered" },
    { "[c", function() require("coverage").jump_prev("uncovered") end, desc = "Prev Uncovered" },
  },
}
