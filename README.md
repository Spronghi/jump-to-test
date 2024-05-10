# Jump to test

A simple nvim plugin that check for the relative test file.

I found myself searching for the same files over and over again when writing tests, this plugin make the process faster.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

``` lua
return {
    'spronghi/jump-to-test',
    dependencies = { 'nvim-telescope/telescope.nvim' }
}
```

## Dependencies

The plugin uses [sharkdp/fd](https://github.com/sharkdp/fd) to find the files.

## Commands

`:JumpToTest` is the only command provided.
