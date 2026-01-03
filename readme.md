# Neovim Configuration

A Neovim configuration for TypeScript/JavaScript development with AI assistants, LSP support, and snacks.nvim-based UI.

**Linux Branch**: Includes debugging (nvim-dap), Harpoon, and smooth scrolling. For other platforms, see the `main` (Windows) or `MacOs` branches.

## 📸 Screenshots

<img width="800" alt="Screenshot 2026-01-03 001057" src="https://github.com/user-attachments/assets/e3d10606-afbf-4403-83cb-f0c61c8f4bff" />

<img width="800" alt="Screenshot 2026-01-03 000331" src="https://github.com/user-attachments/assets/68e9acca-965b-4d65-a73f-5c8066da3302" />




## ✨ Key Features

- 🤖 **AI Development** - CopilotChat (Claude Sonnet 4.5) + OpenCode
- 🔧 **LSP Support** - 8 language servers with auto-installation
- 🎨 **UI** - 6 color schemes, statusline, buffer tabs, notifications
- ⚡ **Navigation** - Leap.nvim, snacks picker, Harpoon
- 🌳 **Git Integration** - lazygit, gitsigns, fugitive
- 💾 **Auto-save & Sessions** - Automatic file saving and session management
- 🐛 **Debugging** - nvim-dap for JavaScript/TypeScript
- 📜 **Smooth Scrolling** - neoscroll
- 🎯 **65+ Plugins** - Complete setup

## 📋 Requirements

### Core (Required)

- **Neovim** >= 0.10.0
- **Git** - Version control
- **Node.js & npm** - LSP servers and formatters
- **Bash/Zsh** - Terminal shell
- **Nerd Font** - For icons (0xProto, JetBrainsMono, FiraCode, etc.)

### Recommended Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **ripgrep** | Fast searching/grepping | `sudo apt install ripgrep` (Ubuntu/Debian)<br>`sudo pacman -S ripgrep` (Arch)<br>`sudo dnf install ripgrep` (Fedora) |
| **fd** | Better file finding | `sudo apt install fd-find` (Ubuntu/Debian)<br>`sudo pacman -S fd` (Arch)<br>`sudo dnf install fd-find` (Fedora) |
| **lazygit** | Git TUI | [Install guide](https://github.com/jesseduffield/lazygit#installation) |
| **yazi** | File manager integration | [Install guide](https://github.com/sxyazi/yazi#installation) |

#### Quick Install All Dependencies

**Ubuntu/Debian**:
```bash
sudo apt update
sudo apt install ripgrep fd-find nodejs npm git neovim
```

**Arch Linux**:
```bash
sudo pacman -S ripgrep fd nodejs npm git neovim
```

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

## 🔌 Plugin Ecosystem (65+ Plugins)

### Core Framework

- **[folke/lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
  - Smart lazy loading, lockfile support
- **[folke/snacks.nvim](https://github.com/folke/snacks.nvim)** - Multi-purpose plugin suite *(centerpiece)*
  - Replaces: dashboard, file explorer, fuzzy finder, notifications, and more
  - Modules: bufdelete, dashboard, explorer, indent, picker, words, notifier, zen, zoom, scratch, lazygit, rename, gitbrowse
- **[nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Utility library
  - Required dependency for many plugins

### LSP & Completion

- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP client configuration
  - Configured servers: lua_ls, ts_ls, cssls, html, jsonls, eslint, cssmodules_ls, css_variables
- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/tool installer
  - Dependencies: mason-lspconfig.nvim, mason-tool-installer.nvim
- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion engine
  - Sources: cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
  - Dependency: friendly-snippets (snippet collection)
- **[saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)** - LuaSnip completion source
- **[folke/lazydev.nvim](https://github.com/folke/lazydev.nvim)** - Neovim Lua development
  - Provides proper Lua types and completions
- **[stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
  - Formatters: stylua, prettierd, prettier, shfmt
- **[nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)** - Null-ls replacement
- **[dmmulroy/tsc.nvim](https://github.com/dmmulroy/tsc.nvim)** - TypeScript compiler integration

### AI Assistants

- **[CopilotC-Nvim/CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - GitHub Copilot chat
  - Dependency: copilot.lua
  - Configured model: Claude Sonnet 4.5
  - Keymaps: `<leader>cp` to toggle
- **[zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - Copilot integration
- **[NickvanDyke/opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)** - AI coding assistant
  - Requires: OpenCode CLI tool installed
  - Keymaps: `<C-.>` toggle, `ga` add to context, `<C-a>` ask

### Debugging

- **[mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug Adapter Protocol client
  - Core debugging functionality
- **[rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - UI for nvim-dap
  - Visual debugging interface with breakpoints, variables, call stack
- **[mxsdev/nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js)** - JavaScript/TypeScript debugging
  - Node.js and browser debugging support
- **[microsoft/vscode-js-debug](https://github.com/microsoft/vscode-js-debug)** - VS Code JS debugger
  - Integrated via nvim-dap-vscode-js

### Syntax & Parsing

- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting
  - Auto-installed parsers: lua, vim, javascript, typescript, html, json, elixir, heex, c, query, vimdoc
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
- **[echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)** - Minimal plugin collection
- **[nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** - File icons
  - Required by many UI plugins
- **[norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)** - Color code highlighter
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
- **[ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file bookmarking
  - Fast file switching with numbered marks
  - Keymaps: `<leader>a` add file, `<C-e>` toggle menu, `<C-h/j/k/l>` jump to marks 1-4
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
- **[tpope/vim-surround](https://github.com/tpope/vim-surround)** - Surround text objects
  - Commands: `cs` change surround, `ds` delete surround, `ys` add surround
- **[mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi)** - Multiple cursors
- **[sQVe/sort.nvim](https://github.com/sQVe/sort.nvim)** - Sorting utility
- **[Pocco81/auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)** - Auto-save files
  - Debounce: 250ms on TextChanged event

### Terminal & Sessions

- **[akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
  - Shell: bash/zsh
  - Keymap: `ä` to toggle
- **[echasnovski/mini.sessions](https://github.com/echasnovski/mini.sessions)** - Session management
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
| `<leader>ss` | LSP symbols | snacks.picker |
| `<leader>n` | Toggle file explorer | snacks.explorer |
| `<leader>-` | Open yazi at current file | yazi.nvim |
| `<leader>cw` | Open yazi at working directory | yazi.nvim |
| `<c-up>` | Resume last yazi session | yazi.nvim |

### Harpoon

| Key | Action |
|-----|--------|
| `<leader>a` | Add file to harpoon |
| `<C-e>` | Toggle harpoon menu |
| `<C-h>` | Jump to harpoon mark 1 |
| `<C-t>` | Jump to harpoon mark 2 |
| `<C-n>` | Jump to harpoon mark 3 |
| `<C-s>` | Jump to harpoon mark 4 |

### Buffer Management

| Key | Action |
|-----|--------|
| `Ö` | Previous buffer *(Nordic layout)* |
| `Ä` | Next buffer *(Nordic layout)* |
| `<leader>b` | Pick buffer (interactive) |
| `<F6>` | Delete buffer |
| `Å` | Switch to previously edited buffer *(Nordic layout)* |
| `vie` | Select entire file content |
| `yie` | Copy entire file content |

### Window Navigation

| Key | Action |
|-----|--------|
| `<A-h>` | Move to left window |
| `<A-j>` | Move to window below |
| `<A-k>` | Move to window above |
| `<A-l>` | Move to right window |
| `<A-S-h>` | Move window to far left |
| `<A-S-j>` | Move window to bottom |
| `<A-S-k>` | Move window to top |
| `<A-S-l>` | Move window to far right |

### LSP Operations

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gI` | Implementations |
| `gy` | Type definitions |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>gf` | Format buffer/selection |
| `<leader>e` | Open diagnostic float |
| `<leader>i` | Add missing imports |
| `<leader>lr` | LSP references |

### Debugging

| Key | Action |
|-----|--------|
| `<F5>` | Continue/Start debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last debug session |

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
| `<leader>gd` | Git diff (hunks) | snacks.nvim |
| `<leader>gB` | Git browse (open in browser) | snacks.nvim |
| `]g` / `[g` | Navigate git hunks (in explorer) | snacks.explorer |

### AI Assistants

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>cp` | Toggle CopilotChat | CopilotChat |
| `<C-.>` | Toggle OpenCode | opencode.nvim |
| `ga` | Add to OpenCode (N/V) | opencode.nvim |
| `<C-a>` | Ask OpenCode (Visual) | opencode.nvim |

### Search & Replace

| Key | Action | Plugin |
|-----|--------|--------|
| `<leader>gr` | Open GrugFar (search/replace) | grug-far.nvim |
| `<leader>rs` | Grep word under cursor | snacks.picker |
| `<leader>rn` | Find & replace word under cursor | builtin |
| `s` | Leap forward | leap.nvim |
| `S` | Leap backward | leap.nvim |
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

> **Note on Nordic Keyboard Layout**: This config includes keybindings optimized for Nordic keyboards (Ö, Ä, Å keys for buffer navigation). If you're using a different layout, you may want to remap these in `lua/vim-options.lua:124-129`.

## 🛠️ Configuration Structure

```
nvim/
├── init.lua                    # Entry point, lazy.nvim bootstrap
├── lua/
│   ├── vim-options.lua        # Core Vim settings & keymaps
│   ├── neovide.lua            # Neovide GUI configuration
│   └── plugins/               # Plugin configurations (auto-loaded by lazy.nvim)
│       ├── snacks/            # Snacks.nvim module configs
│       │   ├── init.lua       # Main snacks setup
│       │   ├── bufdelete.lua  # Buffer deletion config
│       │   ├── dashboard.lua  # Startup dashboard
│       │   ├── explorer.lua   # File explorer config
│       │   ├── indent.lua     # Indent guides
│       │   ├── picker.lua     # Fuzzy finder config
│       │   └── words.lua      # Word highlighting
│       ├── lsp-config.lua     # LSP server configurations
│       ├── completions.lua    # nvim-cmp setup
│       ├── theme.lua          # Color scheme configuration
│       ├── conform.lua        # Formatter setup
│       ├── copilotchat.lua    # CopilotChat config
│       ├── opencode.lua       # OpenCode config
│       ├── treesitter.lua     # Treesitter config
│       ├── debugging.lua      # nvim-dap config (Linux/macOS)
│       ├── harpoon.lua        # Harpoon config (Linux/macOS)
│       ├── smooth-scroll.lua  # Neoscroll config (Linux/macOS)
│       ├── lualine.lua        # Statusline config
│       ├── bufferline.lua     # Buffer tabs config
│       ├── noice.lua          # UI enhancements
│       ├── gitsigns.lua       # Git signs config
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
│       ├── none-ls.lua        # None-ls setup
│       ├── tsc.lua            # TypeScript compiler
│       └── minicons.lua       # Mini.nvim setup
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

### Formatters (via conform.nvim)

| Language/File Type | Formatter | Options |
|-------------------|-----------|---------|
| Lua | stylua | Default |
| JavaScript/JSX | prettierd → prettier | `--no-semi`, `--single-quote` |
| TypeScript/TSX | prettierd → prettier | `--no-semi`, `--single-quote` |
| HTML | prettierd → prettier | `--no-semi`, `--single-quote` |
| CSS/SCSS | prettierd → prettier | `--no-semi`, `--single-quote` |
| JSON/JSONC | prettierd → prettier | `--no-semi`, `--single-quote` |
| Markdown | prettierd → prettier | `--no-semi`, `--single-quote` |
| YAML | prettierd → prettier | `--no-semi`, `--single-quote` |
| Shell/Bash | shfmt | `-i 2 -ci` (2 space indent, case indent) |
| Fallback | trim_whitespace | Removes trailing whitespace |

> **Note**: Formatters use prettierd (daemon) as primary, falling back to prettier if unavailable.

### Treesitter Parsers (Auto-Install)

- **Core**: lua, vim, vimdoc, query, c
- **Web**: javascript, typescript, html, json
- **Elixir**: elixir, heex

Additional parsers will be automatically installed when you open files of that type.

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
   lspconfig.your_new_server.setup({
     capabilities = capabilities,
     on_attach = on_attach,
     -- server-specific options
   })
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
2. Check installed parsers: `:TSInstallInfo`
3. Manually install parser: `:TSInstall <language>`
4. Check health: `:checkhealth nvim-treesitter`
5. Clear parser cache:
   ```bash
   rm -rf ~/.local/share/nvim/tree-sitter
   ```
6. On Linux, ensure you have build tools: `sudo apt install build-essential` (Ubuntu/Debian)

### CopilotChat / OpenCode Not Working

**Symptoms**: AI assistants don't respond or show errors

**Solutions**:
- **CopilotChat**:
  1. Check GitHub Copilot subscription is active
  2. Authenticate: `:Copilot auth`
  3. Check status: `:Copilot status`
  4. Restart LSP: `:LspRestart`

- **OpenCode**:
  1. Ensure OpenCode CLI is installed and in PATH
  2. Check OpenCode is running: `opencode --version`
  3. Restart OpenCode service if needed
  4. Check plugin config: `lua/plugins/opencode.lua`

### Debugging Not Working

**Symptoms**: nvim-dap doesn't start, breakpoints don't work

**Solutions**:
1. Check if js-debug-adapter is installed: `:Mason`
2. Verify debugger configuration: `lua/plugins/debugging.lua`
3. Check DAP UI is loaded: `:lua require('dapui').toggle()`
4. Check logs: `:DapShowLog`
5. Manually install debugger: `:MasonInstall js-debug-adapter`

### Performance Issues

**Symptoms**: Neovim feels slow, high CPU usage, lag when typing

**Solutions**:
1. Disable auto-save temporarily: `:ASToggle`
2. Check for problematic plugins: `:Lazy profile`
3. Check background processes: `htop` or `top`
4. Disable smooth scrolling: Comment out neoscroll in `lua/plugins/smooth-scroll.lua`
5. Check Treesitter highlighting: `:TSDisable highlight`

### Harpoon Not Working

**Symptoms**: Harpoon marks don't persist or keybindings don't work

**Solutions**:
1. Check Harpoon config: `lua/plugins/harpoon.lua`
2. Verify keybindings: `:map <C-e>` should show harpoon mapping
3. Clear Harpoon state:
   ```bash
   rm -rf ~/.local/share/nvim/harpoon.json
   ```
4. Restart Neovim

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
