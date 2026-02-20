# kmymoney.nvim

A simple neovim plugin to read KMyMoney '*.kmy' data files regardless of
whether they're compressed or not.

If the file was compressed, it is recompressed when writing

CAUTION: This is my first attempt at a neovim plugin. It seems to work
but there may be things wrong with it.

## Requirements

- gzip

## Installation

Install the plugin with your preferred package manager

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{ "Silver-Saucepan/kmymoney.nvim" }
```

### Other package managers are available
