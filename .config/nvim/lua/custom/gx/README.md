# gx-overrides

## Purpose

The `gx-overrides` plugin enhances the functionality of the `gx` keybinding in Neovim. By default, `gx` opens URLs or files under the cursor in your browser or external programs. This plugin extends that capability with custom, dynamic URL generation based on specific patterns that you define.

### Key Features

- **Dynamic Pattern Matching**: Define your own Lua patterns to match text under the cursor.
- **Custom URL Generation**: Generate URLs dynamically based on the matched patterns, with the option to use project-specific or global configurations.
- **Platform Support**: Includes built-in support for GitHub pull requests and Azure DevOps work items.
- **Cross-Platform Compatibility**: Automatically chooses the appropriate command to open URLs on macOS, Windows, and Linux.
- **Fallback Mechanisms**: Uses global variables or environment variables when repository information is missing.

## Installation

This plugin can be installed using any plugin manager for Neovim. For example, using **packer.nvim**:

```lua
use {
  'your-username/gx-overrides',
  config = function()
    require('custom.gx-overrides').setup({
      patterns = {
        -- Your custom patterns
      },
    })
  end
}
```

## Configuration

### Example

Here is an example configuration:

```lua
require('custom.gx-overrides').setup({
  patterns = {
    {
      pattern = "^#(%d+)$",
      url = function(pr_num)
        return "https://github.com/org/repo/pull/" .. pr_num
      end,
    },
  },
})
```

The `patterns` table holds the custom Lua patterns and their corresponding URL generation logic.
