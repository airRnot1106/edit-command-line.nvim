# edit-command-line.nvim

Edit command line in a floating window.

## Installation

```lua
{
  "airRnot1106/edit-command-line.nvim",
  config = function()
    require("edit-command-line").setup()
  end
}
```

## Usage

```
:EditCommandLine
```

```lua
vim.keymap.set("n", "<leader>e", require("edit-command-line").open)
```

## LICENSE

MIT
