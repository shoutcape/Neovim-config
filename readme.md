# Neovim Configuration

Welcome to my first Neovim configuration repository!

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Plugins](#plugins)
- [Screenshots](#screenshots)

## Features

- **Fast and lightweight**: Nvim = SPEED
- **Extensible**: Easily add or remove plugins to suit your needs.
- **LSP Support**: Built-in support for Language Server Protocol.
- **Autocomplete**: Powered by completion plugins for a smooth coding experience.
- **Syntax Highlighting**: Improved syntax highlighting for various languages.
- **File Explorer**: Navigate your project easily with a tree view and Telescope.

## Installation

### Steps


1. **Install Neovim**:

    https://github.com/neovim/neovim/blob/master/INSTALL.md

2. **Clone this Repository**:

    Linux

        git clone https://github.com/shoutcape/nvim-config ~/.config/nvim

    Windows

        git clone https://github.com/shoutcape/nvim-config $env:LOCALAPPDATA\nvim

3. **Start Neovim**:

           nvim

## Configuration

### Basic Settings

Basic settings are configured in `lua\vim-options.lua`. This includes options like line numbers, tab width, and most keymaps.

### Plugin Management

Plugins are managed using [Lazy.vim](https://www.lazyvim.org/). Configurations for plugins can be found in `lua/plugins`.

## Plugins

Here are most of the plugins included in this configuration:

- [alpha-nvim](https://github.com/goolord/alpha-nvim): Provides a customizable startup screen for Neovim.
- [catppuccin](https://github.com/Pocco81/Catppuccino.nvim): A color scheme for Neovim.
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): A completion plugin for Neovim's built-in LSP.
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip): Integration between cmp-nvim and LuaSnip for snippet completion.
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git signs in the sign column.
- [harpoon](https://github.com/ThePrimeagen/harpoon): A bookmarking plugin for Neovim.
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim): Displays indent guides in Neovim.
- [lazy.nvim](https://github.com/tjdevries/lazy.nvim): Asynchronous plugin loading for Neovim.
- [leap.nvim](https://github.com/ggandor/leap.nvim): A better movement plugin for Neovim.
- [lualine.nvim](https://github.com/hoob3rt/lualine.nvim): A statusline for Neovim written in Lua.
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip): A snippet engine for Neovim written in Lua.
- [mason.nvim](https://github.com/williamboman/mason.nvim): Markdown preview for Neovim.
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim): A file explorer for Neovim.
- [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim): Smooth scrolling for Neovim.
- [none-ls.nvim](https://github.com/neovim/nvim-lspconfig): A lightweight LSP client for Neovim.
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs): Automatic insertion of pairs in Neovim.
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion plugin for Neovim.
- [nvim-dap](https://github.com/mfussenegger/nvim-dap): Debug Adapter Protocol support for Neovim.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): User interface for debugging in Neovim.
- [nvim-dap-vscode-js](https://github.com/mfussenegger/nvim-dap-vscode-js): Debugging support for JavaScript in Neovim.
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Quickstart configurations for the LSP client in Neovim.
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Syntax trees for Neovim.
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons): Icons for Neovim plugins.
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): Utility functions for Neovim plugin development.
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim): Terminal management for Neovim.
- [vim-css-color](https://github.com/ap/vim-css-color): CSS color preview for Neovim.
- [vim-fugitive](https://github.com/tpope/vim-fugitive): Git integration for Neovim.
- [vim-repeat](https://github.com/tpope/vim-repeat): Repeats plugin mappings with "." in Neovim.
- [vim-surround](https://github.com/tpope/vim-surround): Surround text objects in Neovim.
- [vim-wakatime](https://github.com/wakatime/vim-wakatime): WakaTime integration for Neovim.
- [which-key.nvim](https://github.com/folke/which-key.nvim): Key binding visualization for Neovim.


### Telescope and Neotree binds

- **Space** + **ff**: Open file finder.
- **Space** + **n**: Toggle file explorer.

## Screenshots

Here are some screenshots of the setup in action:

![Näyttökuva 2024-05-30 002117](https://github.com/shoutcape/nvim-config/assets/74509593/1e653bbd-5fe5-470f-b056-50194f523923)
![Näyttökuva 2024-05-30 002011](https://github.com/shoutcape/nvim-config/assets/74509593/c5739752-c17f-455b-acf2-72ebe39e3028)


