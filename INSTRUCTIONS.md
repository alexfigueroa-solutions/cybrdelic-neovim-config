# Neovim Configuration Manual

## Table of Contents
1. [Introduction](#introduction)
2. [Plugin Manager](#plugin-manager)
3. [File Explorer](#file-explorer)
4. [Color Scheme](#color-scheme)
5. [Status Line](#status-line)
6. [Fuzzy Finder](#fuzzy-finder)
7. [LSP and Autocompletion](#lsp-and-autocompletion)
8. [Treesitter](#treesitter)
9. [Git Integration](#git-integration)
10. [Terminal Integration](#terminal-integration)
11. [Keybinding Hints](#keybinding-hints)
12. [Code Folding](#code-folding)
13. [Symbol Outline](#symbol-outline)
14. [Autopairs](#autopairs)
15. [Indent Guides](#indent-guides)
16. [Multi-cursor Editing](#multi-cursor-editing)
17. [Comment Management](#comment-management)
18. [Enhanced Command-line Completion](#enhanced-command-line-completion)
19. [Diffview](#diffview)
20. [GitHub Copilot Integration](#github-copilot-integration)
21. [Project-wide Search and Replace](#project-wide-search-and-replace)
22. [Startup Screen](#startup-screen)
23. [Session Management](#session-management)
24. [Markdown Preview](#markdown-preview)
25. [Debugging](#debugging)
26. [Undotree](#undotree)
27. [Minimap](#minimap)
28. [Avante.nvim Integration](#avantenvim-integration)
29. [Key Bindings](#key-bindings)
30. [Custom Autocommands](#custom-autocommands)

## Introduction

This Neovim configuration is designed to provide a feature-rich and efficient development environment. It includes a wide range of plugins and custom settings to enhance your coding experience.

## Plugin Manager

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. It's automatically installed if not present.

## File Explorer

[Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) is used as the file explorer. It provides a tree-like view of your project structure.

- Toggle with `<leader>e`

## Color Scheme

The [Tokyo Night](https://github.com/folke/tokyonight.nvim) color scheme is used, configured for a dark, transparent background.

## Status Line

[Lualine](https://github.com/nvim-lualine/lualine.nvim) is used for an enhanced status line, showing file information, git status, and more.

## Fuzzy Finder

[Telescope](https://github.com/nvim-telescope/telescope.nvim) is integrated for fuzzy finding files, live grep, and more.

- Find files: `<leader>ff`
- Live grep: `<leader>fg`
- Find buffers: `<leader>fb`
- Help tags: `<leader>fh`

## LSP and Autocompletion

LSP (Language Server Protocol) support is provided through [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and [Mason](https://github.com/williamboman/mason.nvim). Autocompletion is handled by [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).

- Go to definition: `gd`
- Hover information: `K`
- Format code: `<leader>fm`

## Treesitter

[Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) is used for improved syntax highlighting and code parsing.

## Git Integration

Git integration is provided through [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) and [vim-fugitive](https://github.com/tpope/vim-fugitive).

- Git status: `<leader>gs`
- Git diff: `<leader>gd`

## Terminal Integration

[Toggleterm](https://github.com/akinsho/toggleterm.nvim) is used for integrated terminal functionality.

- Toggle terminal: `<C-\>`

## Keybinding Hints

[Which-key](https://github.com/folke/which-key.nvim) provides keybinding hints for better discoverability.

## Code Folding

Enhanced code folding is provided by [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo).

## Symbol Outline

[Symbols-outline](https://github.com/simrat39/symbols-outline.nvim) provides a tree-like view for symbols in your code.

- Toggle symbol outline: `<leader>so`

## Autopairs

[nvim-autopairs](https://github.com/windwp/nvim-autopairs) automatically inserts matching pairs of brackets, quotes, etc.

## Indent Guides

[indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) shows indent guides for better code readability.

## Multi-cursor Editing

[vim-visual-multi](https://github.com/mg979/vim-visual-multi) allows for multi-cursor editing.

## Comment Management

[Comment.nvim](https://github.com/numToStr/Comment.nvim) provides easy comment toggling.

## Enhanced Command-line Completion

[wilder.nvim](https://github.com/gelguy/wilder.nvim) enhances the command-line completion experience.

## Diffview

[diffview.nvim](https://github.com/sindrets/diffview.nvim) provides a better interface for viewing git diffs.

- Open Diffview: `<leader>dv`
- Close Diffview: `<leader>dx`
- View File History: `<leader>dh`

## GitHub Copilot Integration

[copilot.lua](https://github.com/zbirenbaum/copilot.lua) integrates GitHub Copilot for AI-assisted coding.

## Project-wide Search and Replace

[nvim-spectre](https://github.com/nvim-pack/nvim-spectre) allows for project-wide search and replace.

- Open Spectre: `<leader>fr`

## Startup Screen

[alpha-nvim](https://github.com/goolord/alpha-nvim) provides a customizable startup screen.

## Session Management

[auto-session](https://github.com/rmagatti/auto-session) automatically manages your Neovim sessions.

## Markdown Preview

[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) allows for real-time preview of markdown files.

- Toggle Markdown Preview: `<leader>mp` (in markdown files)

## Debugging

Debugging support is provided through [nvim-dap](https://github.com/mfussenegger/nvim-dap) and related plugins.

- Start/Continue: `<F5>`
- Step Over: `<F10>`
- Step Into: `<F11>`
- Step Out: `<F12>`
- Toggle Breakpoint: `<leader>b`
- Set Breakpoint: `<leader>B`
- Toggle DAP UI: `<F7>`

## Undotree

[undotree](https://github.com/mbbill/undotree) visualizes the undo history.

- Toggle Undotree: `<leader>u`

## Minimap

[minimap.vim](https://github.com/wfxr/minimap.vim) provides a code minimap for navigation.

- Toggle Minimap: `<leader>mm`

## Avante.nvim Integration

[Avante.nvim](https://github.com/yetone/avante.nvim) is integrated for AI-assisted development.

- Toggle Avante Sidebar: `<leader>aa`
- Refresh Avante Sidebar: `<leader>ar`
- Edit Selected Blocks: `<leader>ae` (in visual mode)
- Conflict Resolution:
  - Choose Ours: `co`
  - Choose Theirs: `ct`
  - Choose All Theirs: `ca`
  - Choose None: `c0`
  - Choose Both: `cb`
  - Choose Cursor: `cc`
  - Next Conflict: `]x`
  - Previous Conflict: `[x`
- Jump between codeblocks:
  - Next Codeblock: `]]`
  - Previous Codeblock: `[[`

## Key Bindings

This configuration includes many custom key bindings for efficient navigation and operation. Some notable ones include:

- Leader key: `<Space>`
- Save file: `<leader>w`
- Quit: `<leader>q`
- Format code: `<leader>fm`
- Change focus globally: `<leader><Tab>`

Window navigation:
- Move left: `<C-h>`
- Move down: `<C-j>`
- Move up: `<C-k>`
- Move right: `<C-l>`

## Custom Autocommands

Several custom autocommands are set up, including:

- Highlight on yank
- Autoformat on save
- Transparent background

This configuration provides a rich set of features for an enhanced Neovim experience. Explore the various plugins and key bindings to make the most of your development environment.
```


