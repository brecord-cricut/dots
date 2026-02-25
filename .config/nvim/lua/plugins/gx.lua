--- NOTE: This requires the user to define needed variables in the global vim config context. They can either be deinfed
--- here, or another easy way to do this is to ensure project-level settings are enabled with `vim.opt.exrc = true`.
--- Then define the globals in the file `/your/project/root/.nvim.lua`:
--- ```lua
--- vim.g.gx = vim.tbl_deep_extend("force", vim.g.gx or {}, {
---   DevOps = { org = "foo", proj = "bar" },
--- })
--- ```

---@type GxPattern
local git_hub_override = {
  pattern = "^[%(|%[]?#(%d+)[%)|%]]?",

  -- This implementation checks if the current directory is part of a git-tracked repository.
  -- If it is, it extracts the remote URL and parses the organization and repository name.
  -- Using this information, it constructs a GitHub Pull Request URL.
  -- If the repository information cannot be retrieved, it falls back to predefined global values.
  url = function(pr_num)
    local function resolve_remote_url(path)
      local remote_url = vim.fn.system({ "git", "-C", path, "config", "--get", "remote.origin.url" })
      -- Trim trailing whitespace and newlines
      remote_url = remote_url and remote_url:gsub("%s+$", "")
      if remote_url and remote_url ~= "" then
        -- Check if it's a web URL (https://, http://) or SSH URL (git@)
        if remote_url:match("^https?://") or remote_url:match("^git@") then
          return remote_url
        else
          -- It's a local path, resolve it recursively
          return resolve_remote_url(remote_url)
        end
      end
      return nil
    end

    local is_git_tracked =
      vim.fn.system({ "git", "-C", vim.uv.cwd(), "rev-parse", "--is-inside-work-tree" }):match("true")

    if is_git_tracked then
      local remote_url = resolve_remote_url(vim.uv.cwd())
      if remote_url then
        local org, repo = remote_url:match("github.com[/:](.-)/(.+)%.git")
        if org and repo then
          return "https://github.com/" .. org .. "/" .. repo .. "/pull/" .. pr_num
        end
      end
    end

    -- Fallback to the globals
    local gx = vim.g.gx or {}
    local gh = gx.GitHub or {}
    local org, repo = gh.org, gh.repo

    if not (org and repo) then
      vim.notify("gx: GitHub pattern found, but globals not defined as expected.")
      return nil
    end

    return "https://github.com/" .. org .. "/" .. repo .. "/pull/" .. pr_num
  end,
}

---@type GxPattern
local dev_ops_override = {
  pattern = {
    "^AB#(%d+)$",
    "^%[AB#(%d+)%]$",
    "^%(AB#(%d+)%)$",
    "^AB#(%d+):$",
    "^AB#(%d+)|$",
  },
  url = function(ticket_num)
    vim.notify("Hit")
    local gx = vim.g.gx or {}
    local dev_ops = gx.DevOps or {}
    local org, proj = dev_ops.org, dev_ops.proj

    -- Attempt to find them through environment variables
    if not (org and proj) then
      org = vim.env.DEVOPS_ORG
      proj = vim.env.DEVOPS_PROJ
    end

    if not (org and proj) then
      vim.notify("gx: DevOps pattern found, but globals not defined as expected.")
      return nil
    end

    return "https://dev.azure.com/" .. org .. "/" .. proj .. "/_workitems/edit/" .. ticket_num
  end,
}

return {
  dir = vim.fn.stdpath("config") .. "/lua/custom/gx",
  main = "custom.gx",
  ---@type GxConfig
  opts = {
    patterns = {
      git_hub_override,
      dev_ops_override,
    },
  },
}
