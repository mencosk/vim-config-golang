# Neovim Configuration

Personal Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. Requires **Neovim 0.12+**.

## Structure

```
.
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua         # lazy.nvim bootstrap & setup
│   │   ├── options.lua      # Editor options (leader, indentation, etc.)
│   │   ├── keymaps.lua      # Custom key mappings
│   │   ├── autocmds.lua     # Autocommands (LSP, treesitter, Go, etc.)
│   │   └── keybindings_help.lua  # :Keymaps floating window
│   └── plugins/             # One file per plugin (lazy.nvim convention)
│       ├── nvim-treesitter.lua
│       ├── telescope.lua
│       ├── lsp-config-mason.lua
│       ├── nvim-tree.lua
│       ├── copilot.lua
│       ├── avante.lua
│       └── ...              # 27 plugin specs total
└── ftplugin/
    └── java.lua             # Java filetype settings
```

## Requirements

| Dependency | Purpose |
|---|---|
| [Neovim](https://neovim.io) >= 0.12 | Editor |
| [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter) >= 0.26 | Parser compilation (`brew install tree-sitter-cli`) |
| A C compiler | Building tree-sitter parsers |
| `tar` + `curl` | Parser downloads |
| [Node.js](https://nodejs.org) | Copilot, markdown-preview, etc. |
| [Go](https://go.dev) | Go development (gopls, vim-go) |
| [Java](https://adoptium.net) | Java development (jdtls, Maven) |

## Plugin Highlights

- **Treesitter** — syntax highlighting, textobjects (select/move/swap), indent, incremental selection
- **LSP** — Mason + nvim-lspconfig for language server management
- **Completion** — nvim-cmp with LSP, snippets (LuaSnip), buffer sources
- **AI** — Copilot + Avante (LLM chat interface)
- **Navigation** — Telescope (fuzzy finder), NvimTree (file explorer), vim-go
- **Git** — Gitsigns, git.nvim
- **UI** — Catppuccin/Gruvbox themes, lualine, indent-blankline, noice
- **Languages** — Go, Java, Rust, Lua, Proto, Markdown, Mermaid

## Key Mappings

Leader key is `<Space>`. Press `<Leader>?` inside Neovim for a full keybindings reference.

### General
| Key | Action |
|---|---|
| `<Leader>w` | Save file |
| `<Leader>q` | Force quit |
| `<Leader>n` | Toggle file tree |
| `<Leader>e` | Copy filepath to clipboard |
| `<Leader>rw` | Rename word under cursor (global) |

### LSP
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>gd` | Telescope definitions |
| `<leader>gr` | Telescope references |

### Treesitter Textobjects
| Key | Mode | Action |
|---|---|---|
| `af` / `if` | x, o | Function outer/inner |
| `ac` / `ic` | x, o | Class outer/inner |
| `aa` / `ia` | x, o | Parameter outer/inner |
| `]]` / `[[` | n, x, o | Next/previous function start |
| `<leader>sn` / `<leader>sp` | n | Swap parameter next/previous |

### Splits & Navigation
| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between splits |
| `<C-o>` / `<C-i>` | Jump back/forward (centered) |
| `n` / `N` | Search next/prev (centered) |

### Go
| Key | Action |
|---|---|
| `<Leader>mb` | Maven Build |
| `<Leader>mt` | Maven Test |
| `<Leader>mr` | Maven Run (Spring Boot) |

## Install

```bash
git clone https://github.com/emencos/nvim ~/.config/nvim
nvim  # lazy.nvim will auto-install plugins
```

Run `:TSUpdate` after first launch to install tree-sitter parsers.

## References

- [gopls documentation](https://github.com/golang/tools/blob/master/gopls/doc/vim.md)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
