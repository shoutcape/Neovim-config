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
- **Other**: toggleterm, mini.sessions, obsidian.nvim, markdown-preview

Language servers: `lua_ls`, `tsc` (TypeScript 7; set `vim.g.use_tsc = false` in `init.lua` for
`ts_ls`), `eslint`, `cssls`, `cssmodules_ls`, `css_variables`, `html`, `jsonls`, `kotlin_lsp`,
`mdx_analyzer`.

## Keymaps

<<<<<<< HEAD
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
=======
**Fedora**:
```bash
sudo dnf install ripgrep fd-find nodejs npm git neovim
```

### Optional

- **Neovide** - GPU-accelerated Neovim GUI ([Install guide](https://neovide.dev/installation.html))
- **0xProto Nerd Font** - Recommended font (pre-configured for Neovide)

## 🚀 Installation

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone the Linux branch**:
   ```bash
   git clone -b Linux https://github.com/shoutcape/nvim-config ~/.config/nvim
   ```

3. **Launch Neovim**:
   ```bash
   nvim
   ```
   - Lazy.nvim will automatically install all plugins
   - Mason will auto-install configured LSP servers
   - Wait for all installations to complete (may take 2-3 minutes)

4. **Verify installation**:
   - Check plugins: `:Lazy`
   - Check LSP servers: `:Mason`
   - Check health: `:checkhealth`

5. **Install recommended external tools** (from Requirements section above)

### Post-Installation

- Set your terminal font to a Nerd Font
- For Neovide users: Font is pre-configured (0xProto Nerd Font)
- Restart Neovim after installing external tools
- Run `:checkhealth` to verify everything is working

## 🔌 Plugin Ecosystem (56 Plugins)

### Core Framework

- **[folke/lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
  - Smart lazy loading, lockfile support
- **[folke/snacks.nvim](https://github.com/folke/snacks.nvim)** - Multi-purpose plugin suite *(centerpiece)*
  - Replaces: dashboard, file explorer, fuzzy finder, notifications, and more
  - Modules: bufdelete, dashboard, explorer, indent, picker, zen, zoom, scratch, lazygit, rename, gitbrowse
- **[nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Utility library
  - Required dependency for many plugins

### LSP & Completion

- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP client configuration
  - Configured servers: lua_ls, ts_ls, cssls, html, jsonls, eslint, cssmodules_ls, css_variables, gopls
- **[mason-org/mason.nvim](https://github.com/mason-org/mason.nvim)** - LSP/tool installer
  - Dependencies: mason-lspconfig.nvim, mason-tool-installer.nvim
- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion engine
  - Sources: cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
  - Dependency: friendly-snippets (snippet collection)
- **[saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)** - LuaSnip completion source
- **[folke/lazydev.nvim](https://github.com/folke/lazydev.nvim)** - Neovim Lua development
  - Provides proper Lua types and completions
- **[stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
  - Formatters: stylua, prettierd, prettier
- **[dmmulroy/tsc.nvim](https://github.com/dmmulroy/tsc.nvim)** - TypeScript compiler integration

### AI Assistants

- **herdr-agent** (local, `lua/herdr_agent.lua`) - Send code comments to a coding agent running in a Herdr pane
  - Requires: Neovim running inside a Herdr pane, with an agent in another pane
  - Ask now: comment on a line or selection and send it immediately
  - Review mode: collect comments across files, then send them as one prompt

### Syntax & Parsing

- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting
  - The parser list in `lua/plugins/treesitter.lua` is installed automatically.
- **[windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)** - Auto-close/rename HTML tags
  - Requires: nvim-treesitter

### UI & Themes

#### Active Theme

- **[catppuccin/nvim](https://github.com/catppuccin/nvim)** - Catppuccin color scheme
  - Custom green accents (#32a874)
  - Flavour: auto (latte for light, mocha for dark)

#### Alternative Themes

- **[rose-pine/neovim](https://github.com/rose-pine/neovim)** - Rose Pine
- **[ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)** - Gruvbox
- **[rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)** - Kanagawa
- **[craftzdog/solarized-osaka.nvim](https://github.com/craftzdog/solarized-osaka.nvim)** - Solarized Osaka
- **[folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Tokyo Night

#### UI Components

- **[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline
  - Dependency: nvim-web-devicons
  - Custom green theme, macro recording indicator, Git integration
- **[akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs
  - Dependency: nvim-web-devicons
  - LSP diagnostics integration, custom styling
- **[folke/noice.nvim](https://github.com/folke/noice.nvim)** - Enhanced UI for messages/cmdline/popupmenu
  - Dependencies: nui.nvim, nvim-notify
  - Custom positioning and styling
- **[rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)** - Notification manager
  - Minimal render style with snacks.nvim integration
- **[MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)** - UI component library
  - Required by noice.nvim
- **[nvim-mini/mini.icons](https://github.com/nvim-mini/mini.icons)** - File icons for snacks
- **[nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** - File icons
  - Required by many UI plugins
- **[catgoose/nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua)** - Color code highlighter
  - Highlights hex colors, RGB, color names in code
- **[RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate)** - Highlight word under cursor
- **[folke/which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding hints
  - Shows available keybindings in a popup

### Navigation & Search

- **Telescope** (via snacks.nvim picker) - Fuzzy finder
  - Integrated into snacks.nvim, no standalone telescope needed
- **[ggandor/leap.nvim](https://github.com/ggandor/leap.nvim)** - Lightning-fast motion
  - Dependency: vim-repeat
  - Keymaps: `s` forward, `S` backward, `gs` from window
- **[tpope/vim-repeat](https://github.com/tpope/vim-repeat)** - Repeat plugin mappings with `.`
- **[MagicDuck/grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)** - Search and replace across files
  - Keymap: `<leader>gr`
- **[folke/trouble.nvim](https://github.com/folke/trouble.nvim)** - Pretty diagnostics/references list
  - Keymaps: `<leader>xx` diagnostics, `<leader>xX` buffer diagnostics
- **[mikavilpas/yazi.nvim](https://github.com/mikavilpas/yazi.nvim)** - Yazi file manager integration
  - Requires: yazi installed
  - Keymaps: `<leader>-` at current file, `<leader>cw` at working directory
- **[karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)** - Smooth scrolling

### Git Integration

- **[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)** - Git command wrapper
  - Provides `:Git` commands
- **[lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git signs & blame
  - Current line blame, git hunk navigation
  - Keymaps: `<leader>gp` preview hunk, `<leader>gt` toggle blame
- **lazygit** (via snacks.nvim) - Git TUI integration
  - Requires: lazygit installed
  - Keymap: `<leader>lg`

### Editing & Text Manipulation

- **[windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets/quotes
  - Treesitter integration, nvim-cmp integration
- **[tpope/vim-surround](https://github.com/tpope/vim-surround)** - Surround text objects (visual `S` is surround)
  - Commands: `cs` change surround, `ds` delete surround, `ys` add surround
- **[mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi)** - Multiple cursors
- **[sQVe/sort.nvim](https://github.com/sQVe/sort.nvim)** - Sorting utility
- **[okuuva/auto-save.nvim](https://github.com/okuuva/auto-save.nvim)** - Auto-save files
  - Debounce: 250ms on TextChanged event

### Terminal & Sessions

- **[akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
  - Shell: bash/zsh
  - Keymap: `ä` to toggle
- **[nvim-mini/mini.sessions](https://github.com/nvim-mini/mini.sessions)** - Session management
  - Auto-writes sessions on exit

### Documentation

- **[iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Live markdown preview
  - Commands: `:MarkdownPreview`, `:MarkdownPreviewStop`, `:MarkdownPreviewToggle`



## ⌨️ Key Bindings

**Leader Key**: `Space`

### File & Buffer Navigation

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader><leader>` | Smart file finder | snacks.picker |
| `<leader>ff` | Find files | snacks.picker |
| `<leader>fi` | Find files (include hidden/ignored) | snacks.picker |
| `<leader>fr` | Recent files | snacks.picker |
| `<leader>fg` | Live grep | snacks.picker |
| `<leader>fb` | Find buffers | snacks.picker |
| `<leader>fc` | Find config files | snacks.picker |
| `<leader>fp` | Find projects | snacks.picker |
| `<leader>å` | Git files | snacks.picker |
| `<leader>fh` | Help tags | snacks.picker |
| `<leader>sk` | Keymaps | snacks.picker |
| `<leader>su` | Undo history | snacks.picker |
| `<leader>sd` | Diagnostics | snacks.picker |
| `<leader>st` | Colorschemes | snacks.picker |
| `<leader>ss` | LSP symbols | snacks.picker |
| `<leader>n` | Toggle file explorer | snacks.explorer |
| `<leader>-` | Open yazi at current file | yazi.nvim |
| `<leader>cw` | Open yazi at working directory | yazi.nvim |
| `<leader>cy` | Resume last yazi session | yazi.nvim |

### Buffer Management

| Key | Action |
|-----|--------|
| `Ö` | Previous buffer *(Nordic layout)* |
| `Ä` | Next buffer *(Nordic layout)* |
| `<leader>b` | Pick buffer (interactive) |
| `<F6>` | Delete buffer |
| `Å` | Switch to previously edited buffer *(Nordic layout)* |
| `vie` | Select entire buffer via the `ie` text object (also `die`, `cie`) |
| `yie` | Yank entire buffer via the `ie` text object, keeping the cursor in place |

### Window Navigation

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to window below |
| `<C-k>` | Move to window above |
| `<C-l>` | Move to right window |
| `<C-S-h>` | Move window to far left |
| `<C-S-j>` | Move window to bottom |
| `<C-S-k>` | Move window to top |
| `<C-S-l>` | Move window to far right |

### LSP Operations

| Key | Action |
|-----|--------|
| `gd` | Go to definition (picker) |
| `gD` | Go to declaration (picker) |
| `gr` | References (picker) |
| `gI` | Implementations (picker) |
| `gy` | Type definitions (picker) |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>gf` | Format buffer/selection |
| `<leader>e` | Open diagnostic float |
| `<leader>i` | Add missing imports |
| `<leader>lr` | LSP references |

### Diagnostics & Trouble

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>xx` | Toggle diagnostics | trouble.nvim |
| `<leader>xX` | Buffer diagnostics | trouble.nvim |
| `<leader>cs` | Symbols | trouble.nvim |
| `<leader>cl` | LSP definitions/references | trouble.nvim |
| `<leader>xL` | Location list | trouble.nvim |
| `<leader>xQ` | Quickfix list | trouble.nvim |
| `<leader>q` | Toggle quickfix | builtin |
| `<A-Down>` | Next quickfix item | builtin |
| `<A-Up>` | Previous quickfix item | builtin |

### Git Operations

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>lg` | Open lazygit | snacks.nvim |
| `<leader>gp` | Preview git hunk | gitsigns |
| `<leader>gt` | Toggle git blame | gitsigns |
| `<leader>gd` | Open Diffview | diffview.nvim |
| `<leader>gB` | Git browse (open in browser) | snacks.nvim |
| `]g` / `[g` | Navigate git hunks (in explorer) | snacks.explorer |

### AI Assistants

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>aa` | Ask agent about line/selection (N/V) | herdr-agent |
| `<leader>ac` | Add review comment (N/V) | herdr-agent |
| `<leader>as` | Send review comments | herdr-agent |
| `<leader>al` | List review comments (quickfix) | herdr-agent |
| `<leader>ad` | Delete review comment under cursor | herdr-agent |
| `<leader>ax` | Clear review comments | herdr-agent |
| `<leader>at` | Choose target agent | herdr-agent |

### Search & Replace

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>gr` | Open GrugFar (search/replace) | grug-far.nvim |
| `<leader>rs` | Grep word under cursor | snacks.picker |
| `<leader>rw` | Find & replace word/selection | builtin |
| `s` | Leap forward | leap.nvim |
| `S` | Leap backward (normal and operator-pending only) | leap.nvim |
| `gs` | Leap from window | leap.nvim |
| `x` / `X` | Leap till forward/backward (V/O) | leap.nvim |
| `*` | Search word under cursor (stay) | builtin |
| `/` | Clear highlights and search | builtin |

### Text Manipulation

| Key | Action | Mode |
|-----|--------|------|
| `<leader>p` | Paste without overwriting register | Visual |
| `J` | Move selected lines down | Visual |
| `K` | Move selected lines up | Visual |
| `ö` | Enter visual block mode *(Nordic layout)* | Normal |

### Terminal & Utilities

| Key | Action |
|-----|--------|
| `ä` | Toggle terminal *(Nordic layout)* |
| `<Esc>` | Exit terminal mode (in terminal) |
| `<A-a>` | Run Python file in terminal |
| `<leader>ms` / `<leader>ml` / `<leader>md` | Save / load / delete session |

### UI & Workflow

| Key | Action |
|-----|--------|
| `<leader>z` | Toggle zen mode |
| `<leader>Z` | Toggle zoom |
| `<leader>.` | Toggle scratch buffer |
| `<leader>S` | Select scratch buffer |
| `<leader>cR` | Rename file |
| `<Esc>` | Clear search + dismiss notifications |
| `<leader>?` | Show buffer keymaps (which-key) |
| `<PageUp>` / `<PageDown>` | Half page up/down |

### Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<C-b>` / `<C-f>` | Scroll docs up/down |
| `<S-Tab>` | Jump forward in snippet |
| `<S-S-Tab>` | Jump backward in snippet |

### Neovide GUI (if using Neovide)

| Key | Action |
|-----|--------|
| `<C-+>` | Increase font size |
| `<C-->` | Decrease font size |
| `<D-Arrow>` | Resize splits |

> **Note on Nordic Keyboard Layout**: This config includes keybindings optimized for Nordic keyboards (Ö, Ä, Å keys for buffer navigation). If you're using a different layout, you may want to remap these in `lua/vim-options.lua`.

## 🛠️ Configuration Structure

```
nvim/
├── init.lua                    # Entry point, lazy.nvim bootstrap
├── lua/
│   ├── vim-options.lua        # Core Vim settings & keymaps
│   ├── neovide.lua            # Neovide GUI configuration
│   ├── colors.lua             # Shared colors
│   ├── herdr_agent.lua        # Herdr agent comments
│   ├── config/
│   │   └── remote_clipboard.lua # Remote clipboard configuration
│   └── plugins/               # Plugin configurations (auto-loaded by lazy.nvim)
│       ├── snacks/            # Snacks.nvim module configs
│       │   ├── init.lua       # Main snacks setup
│       │   ├── dashboard.lua  # Startup dashboard
│       │   ├── explorer.lua   # File explorer config
│       │   ├── indent.lua     # Indent guides
│       │   └── picker.lua     # Fuzzy finder config
│       ├── lsp-config.lua     # LSP server configurations
│       ├── completions.lua    # nvim-cmp setup
│       ├── theme.lua          # Color scheme configuration
│       ├── conform.lua        # Formatter setup
│       ├── herdr.lua          # Herdr agent comments loader
│       ├── treesitter.lua     # Treesitter config
│       ├── smooth-scroll.lua  # Neoscroll config (Linux/macOS)
│       ├── lualine.lua        # Statusline config
│       ├── bufferline.lua     # Buffer tabs config
│       ├── noice.lua          # UI enhancements
│       ├── git-stuff.lua      # Fugitive setup
│       ├── leap.lua           # Leap motion config
│       ├── trouble.lua        # Trouble config
│       ├── toggleterm.lua     # Terminal config
│       ├── autopairs.lua      # Auto-pairs config
│       ├── autotags.lua       # Auto-tags config
│       ├── surround.lua       # Surround config
│       ├── multicursor.lua    # Multiple cursors
│       ├── grug.lua           # Search/replace config
│       ├── yazi.lua           # Yazi file manager
│       ├── which-key.lua      # Keybinding hints
│       ├── colorizer.lua      # Color highlighter
│       ├── textHighlights.lua # Illuminate config
│       ├── markdown-preview.lua
│       ├── mini-sessions.lua  # Session management
│       ├── auto-save.lua      # Auto-save config
│       ├── sort.lua           # Sorting utility
│       ├── lazydev.lua        # Lua dev support
│       ├── tsc.lua            # TypeScript compiler
│       └── minicons.lua       # Mini.icons setup
├── lazy-lock.json             # Plugin version lockfile
└── readme.md                  # This file
```

### Key Files Explained

- **init.lua**: Bootstraps lazy.nvim and loads all configurations
- **lua/vim-options.lua**: Core Neovim settings (line numbers, indentation, keymaps, autocommands)
- **lua/neovide.lua**: GUI-specific settings (font, opacity, animations, keymaps)
- **lua/plugins/**: Each file configures one or more related plugins (auto-loaded by lazy.nvim)
- **lua/plugins/snacks/**: Modular configuration for different snacks.nvim features
- **lazy-lock.json**: Locks plugin versions for reproducibility across installations

## 💻 Language Support

### Configured LSP Servers

| Language | Server | Features | Auto-Install |
|----------|--------|----------|--------------|
| Lua | lua_ls | Neovim API completion, diagnostics | ✅ |
| TypeScript/JavaScript | ts_ls | IntelliSense, diagnostics (8GB memory) | ✅ |
| CSS | cssls | CSS completion, validation | ✅ |
| HTML | html | HTML completion, validation | ✅ |
| JSON | jsonls | JSON schema validation | ✅ |
| ESLint | eslint | Linting for JS/TS | ✅ |
| CSS Modules | cssmodules_ls | CSS modules support | ✅ |
| CSS Variables | css_variables | CSS variable completion | ✅ |
| Go | gopls | Completion, diagnostics, static analysis, formatting | ✅ |

### Formatters (via conform.nvim)

| Language/File Type | Formatter | Options |
|-------------------|-----------|---------|
| Lua | stylua | Default |
| JavaScript/JSX | prettierd → prettier | project config |
| TypeScript/TSX | prettierd → prettier | project config |
| HTML | prettierd → prettier | project config |
| CSS/SCSS | prettierd → prettier | project config |
| JSON/JSONC | prettierd → prettier | project config |
| Markdown | prettierd → prettier | project config |
| YAML | prettierd → prettier | project config |
| Fallback | trim_whitespace | Removes trailing whitespace |

> **Note**: Formatters use prettierd (daemon) as primary, falling back to prettier if unavailable.

### Treesitter Parsers (Auto-Install)

The parser list in `lua/plugins/treesitter.lua` is installed automatically.

## 🎨 Customization

### Switching Themes

1. Open `lua/plugins/theme.lua`
2. Find the line `vim.cmd.colorscheme("catppuccin")`
3. Comment it out and uncomment your desired theme:
   ```lua
   -- vim.cmd.colorscheme("catppuccin")
   vim.cmd.colorscheme("rose-pine")
   ```
4. Restart Neovim or run `:colorscheme <theme-name>`

**Available themes**: `catppuccin`, `rose-pine`, `gruvbox`, `kanagawa`, `solarized-osaka`, `tokyonight`

### Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`)
2. Return a lazy.nvim plugin spec:
   ```lua
   return {
     "author/plugin-name",
     event = "VeryLazy", -- or other lazy-loading options
     config = function()
       require("plugin-name").setup({
         -- your configuration here
       })
     end,
   }
   ```
3. Restart Neovim - lazy.nvim automatically loads all files in `lua/plugins/`
4. Check installation status with `:Lazy`

### Modifying Keymaps

- **Global keymaps**: Edit `lua/vim-options.lua` (starting around line 73)
- **Plugin-specific keymaps**: Edit the relevant plugin config file in `lua/plugins/`
- **LSP keymaps**: Edit `lua/plugins/lsp-config.lua`
- **Snacks keymaps**: Edit files in `lua/plugins/snacks/`

Example - Adding a new keymap in `vim-options.lua`:
```lua
map("n", "<leader>test", ":echo 'Hello!'<CR>", { desc = "Test keymap" })
```

### Adding LSP Servers

1. Open `lua/plugins/lsp-config.lua`
2. Add server name to the `ensure_installed` table:
   ```lua
   ensure_installed = { "lua_ls", "ts_ls", "your_new_server" },
   ```
3. Add server-specific setup (if needed):
   ```lua
   vim.lsp.config("your_new_server", {
     -- server-specific options
   })
   vim.lsp.enable("your_new_server")
   ```
4. Restart Neovim - Mason will auto-install the server
5. Verify with `:Mason` and `:LspInfo`

### Changing Formatters

1. Open `lua/plugins/conform.lua`
2. Add formatter to `formatters_by_ft` table:
   ```lua
   formatters_by_ft = {
     python = { "black", "isort" },
     -- add more here
   },
   ```
3. Optionally customize formatter options in the `formatters` table:
   ```lua
   formatters = {
     black = {
       prepend_args = { "--line-length", "88" },
     },
   },
   ```
4. Install the formatter via Mason: `:MasonInstall black`

### Customizing the Dashboard

Edit `lua/plugins/snacks/dashboard.lua` to change:
- ASCII art header
- Quick action items
- Colors
- Layout

### Disabling Auto-Save

Edit `lua/plugins/auto-save.lua` and set:
```lua
enabled = false,
```

Or toggle it at runtime with `:ASToggle`

## 🐛 Troubleshooting

### Mason Fails to Install Servers

**Symptoms**: `:Mason` shows installation errors

**Solutions**:
1. Verify Node.js is installed: `node --version` (should be v14+)
2. Verify npm works: `npm --version`
3. Try manual installation: `:MasonInstall <server-name>`
4. Update Mason: `:MasonUpdate`
5. Check Mason health: `:checkhealth mason`
6. Check logs: `:MasonLog`
7. Clear Mason cache: Delete `~/.local/share/nvim/mason` and restart

### Icons Not Displaying

**Symptoms**: Squares/boxes instead of icons

**Solutions**:
1. Install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)
2. Set your terminal font to the Nerd Font
   - **GNOME Terminal**: Preferences → Profiles → Text → Custom font
   - **Kitty**: Edit `~/.config/kitty/kitty.conf` and set `font_family`
   - **Alacritty**: Edit `~/.config/alacritty/alacritty.yml` and set `font.normal.family`
3. Recommended fonts: 0xProto Nerd Font, JetBrainsMono Nerd Font, FiraCode Nerd Font
4. Restart your terminal after changing the font

### Telescope/Search Not Working

**Symptoms**: Grep or file finding shows errors like "rg not found" or "fd not found"

**Solutions**:
1. Install ripgrep and fd using your package manager (see Requirements section)
2. Verify they're in PATH:
   - `rg --version`
   - `fd --version`
3. Restart terminal and Neovim
4. If still not working, check your PATH: `echo $PATH`

### Terminal Issues

**Symptoms**: `:ToggleTerm` shows errors or opens wrong shell

**Solutions**:
1. Check your default shell: `echo $SHELL`
2. Check toggleterm config: `lua/plugins/toggleterm.lua`
3. Alternative: Change shell in the config to your preferred shell
4. Restart Neovim after changes

### Lazy.nvim Slow or Errors

**Symptoms**: Plugins won't load, slow startup, sync errors

**Solutions**:
1. Sync plugins: `:Lazy sync`
2. Check plugin health: `:Lazy health`
3. Clear lazy.nvim cache:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   ```
4. Restart Neovim (plugins will reinstall automatically)
5. Check internet connection (required for downloading plugins)
6. Check lockfile: `lazy-lock.json` should exist

### LSP Server Not Working

**Symptoms**: No autocomplete, no diagnostics, no code actions

**Solutions**:
1. Check if server is running: `:LspInfo`
2. Check if Mason installed it: `:Mason`
3. Restart LSP server: `:LspRestart`
4. Check LSP logs: `:LspLog`
5. Check general health: `:checkhealth lsp`
6. For TypeScript: Ensure you're in a project with `package.json` or `tsconfig.json`
7. Manually attach LSP: `:LspStart`

### Treesitter Highlighting Issues

**Symptoms**: Broken syntax colors, parser errors, "no parser installed"

**Solutions**:
1. Update all parsers: `:TSUpdate`
2. Manually install parser: `:TSInstall <language>`
3. Check health: `:checkhealth nvim-treesitter`
4. Clear parser cache:
   ```bash
   rm -rf ~/.local/share/nvim/tree-sitter
   ```
5. On Linux, ensure you have build tools: `sudo apt install build-essential` (Ubuntu/Debian)

### Performance Issues

**Symptoms**: Neovim feels slow, high CPU usage, lag when typing

**Solutions**:
1. Disable auto-save temporarily: `:ASToggle`
2. Check for problematic plugins: `:Lazy profile`
3. Check background processes: `htop` or `top`
4. Disable smooth scrolling: Comment out neoscroll in `lua/plugins/smooth-scroll.lua`
5. Check Treesitter highlighting: `:TSDisable highlight`

### Yazi Integration Issues

**Symptoms**: Yazi doesn't open or shows errors

**Solutions**:
1. Verify yazi is installed: `yazi --version`
2. Check yazi is in PATH: `which yazi`
3. Install yazi following [official guide](https://github.com/sxyazi/yazi#installation)
4. Restart Neovim after installing yazi

---

## 📝 Notes

- **Nordic Keyboard**: Keybindings use Nordic layout (Ö, Ä, Å). Remap in `lua/vim-options.lua` if needed
- **Updates**: Use `:Lazy sync` to update plugins, `:Mason update` to update language servers
>>>>>>> 829aa08 (fix: resolve config review findings and restrict comment move restoration)
