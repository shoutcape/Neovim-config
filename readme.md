# Neovim Configuration

My personal Neovim setup. This is the `MacOs` branch; the `Linux` branch carries the Linux variant.

Requires Neovim 0.12 or newer.

## Installation

1. **Install Neovim**: https://github.com/neovim/neovim/blob/master/INSTALL.md

2. **Clone this branch**:

        git clone -b MacOs https://github.com/shoutcape/Neovim-config ~/.config/nvim

3. **Start Neovim**:

        nvim

   [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself and installs the plugins at the
   commits pinned in `lazy-lock.json`. Mason then installs the language servers, formatters and linters.

### External tools

These are expected on `PATH`: `git`, `rg`, `fd`, `node`, `lazygit`, `yazi`, `tree-sitter` (to build
parsers) and `yarn` (to build markdown-preview). A Nerd Font is needed for the icons.

## Layout

| Path | Contents |
| --- | --- |
| `init.lua` | Bootstraps lazy.nvim and loads the core modules |
| `lua/vim-options.lua` | Options, autocommands and most keymaps |
| `lua/neovide.lua` | Neovide-only settings |
| `lua/colors.lua` | Palette shared by lualine and bufferline |
| `lua/plugins/` | One lazy.nvim spec per file |
| `lua/plugins/snacks/` | snacks.nvim, split by feature |
| `lua/plugins/treeman.lua` | Config-local git worktree commands |
| `after/ftplugin/` | Per-filetype settings |

`nvim-eslint/` is gitignored and holds machine-local ESLint override configs.

## Plugins

- **Plugin manager**: lazy.nvim
- **UI**: catppuccin, lualine, bufferline, noice + nvim-notify, which-key, snacks.nvim (dashboard,
  picker, explorer, indent, statuscolumn, words, zen, scratch)
- **LSP and tooling**: nvim-lspconfig on the built-in `vim.lsp.config` API, mason,
  mason-lspconfig, mason-tool-installer, lazydev, conform (formatting), nvim-lint (ktlint),
  trouble, tsc.nvim
- **Completion**: nvim-cmp with LuaSnip and friendly-snippets
- **Syntax**: nvim-treesitter (`main` branch), nvim-ts-autotag, mdx.nvim, nvim-colorizer
- **Navigation**: leap, yazi.nvim, grug-far, nvim-bqf
- **Git**: gitsigns, vim-fugitive, diffview, lazygit (through snacks)
- **Editing**: nvim-autopairs, vim-surround, vim-visual-multi, sort.nvim, auto-save, neoscroll
- **Other**: toggleterm, mini.sessions, obsidian.nvim, markdown-preview, opencode.nvim

Language servers: `lua_ls`, `tsc` (TypeScript 7; set `vim.g.use_tsc = false` in `init.lua` for
`ts_ls`), `eslint`, `cssls`, `cssmodules_ls`, `css_variables`, `html`, `jsonls`, `kotlin_lsp`,
`mdx_analyzer`.

## Keymaps

The leader key is `Space`. A few starting points:

| Key | Action |
| --- | --- |
| `<leader><leader>` | Smart file finder |
| `<leader>ff` / `<leader>fg` | Find files / live grep |
| `<leader>n` | File explorer |
| `<leader>-` | Yazi at the current file |
| `<leader>gf` | Format buffer or selection |
| `<leader>lg` | Lazygit |
| `<leader>wtc` / `wts` / `wtd` | Create / switch / delete a worktree |
| `<leader>sk` | Search all keymaps |
| `<leader>?` | Buffer-local keymaps (which-key) |

The layout assumes a Finnish keyboard: `ö`, `ä`, `Ö`, `Ä` and `Å` are bound to visual block, the
terminal toggle and buffer navigation.

## Screenshots

From an earlier version of this config (2024):

![Näyttökuva 2024-05-30 002117](https://github.com/shoutcape/nvim-config/assets/74509593/1e653bbd-5fe5-470f-b056-50194f523923)
![Näyttökuva 2024-05-30 002011](https://github.com/shoutcape/nvim-config/assets/74509593/c5739752-c17f-455b-acf2-72ebe39e3028)
