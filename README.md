# kmymoney.nvim

A simple neovim plugin to read KMyMoney '*.kmy' data files regardless of
whether they're compressed or not.

This plugin does not (re)compress the file when writing (KMyMoney will
read the uncompressed version and compress it at the next save)

CAUTION: This is my first attempt at a neovim plugin. It seems to work
but there may be things wrong with it.

## Installation

Install the plugin with your preferred package manager

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{ "Silver-Saucepan/kmymoney.nvim" }
```

### Other package managers are available
