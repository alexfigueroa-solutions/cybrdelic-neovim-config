vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'
vim.opt.cmdheight = 0
vim.opt.pumheight = 10
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.list = true
vim.opt.listchars = { tab = '>> ', trail = '.', nbsp = 'x', extends = '>', precedes = '<' }
vim.opt.fillchars = { eob = ' ' }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'n'

-- Mouse and clipboard
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Indentation and tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.shiftround = true

-- Folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'

-- Performance settings
vim.opt.lazyredraw = false
vim.opt.synmaxcol = 240

-- Title and status
vim.opt.title = true
vim.opt.titlestring = '%<%F%=%l/%L - nvim'

-- Wildmenu and completion
vim.opt.wildignorecase = true
vim.opt.wildignore:append { '*/node_modules/*', '*/vendor/*', '*.o', '*.obj', '*.dll', '*.exe' }
vim.opt.wildmode = 'longest:full,full'
vim.opt.completeopt = 'menu,menuone,noselect'

-- Backup and swap files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- Undo settings
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'data' .. '/undodir'
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.stdpath 'data' .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

-- Scrolling
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.virtualedit = 'block'

-- Spelling
vim.opt.spelllang = { 'en_us' }
vim.opt.whichwrap:append '<,>,[,],h,l'

-- Colors and themes
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd 'syntax enable'
vim.cmd 'syntax on'

-- Neovide settings (if using Neovide)
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_transparency = 0.85
  vim.g.neovide_floating_blur_amount_x = 10.0
  vim.g.neovide_floating_blur_amount_y = 10.0
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = 'railgun'
end

-- Install and set up lazy.nvim plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- Clone lazy.nvim if it's not installed
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- Latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup using lazy.nvim
require('lazy').setup {
  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- For file icons
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
            default = '*',
            highlight = 'NeoTreeFileIcon',
          },
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              added = '',
              modified = '',
              deleted = '✖',
              renamed = '',
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
        },
        window = {
          position = 'left',
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false, -- disable 'nowait' if you have existing combos starting with this char that you want to use
            },
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            ['t'] = 'open_tabnew',
            ['w'] = 'open_with_window_picker',
            ['C'] = 'close_node',
            ['a'] = 'add',
            ['A'] = 'add_directory',
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy',
            ['m'] = 'move',
            ['q'] = 'close_window',
          },
        },
        filesystem = {
          filtered_items = {
            visible = true, -- This will show hidden files
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        buffers = {
          follow_current_file = true,
          group_empty_dirs = true,
          show_unloaded = true,
        },
        git_status = {
          window = {
            position = 'float',
          },
        },
        event_handlers = {
          {
            event = 'neo_tree_buffer_enter',
            handler = function()
              vim.cmd [[
                if exists('b:neo_tree_source') && b:neo_tree_source == "filesystem"
                  silent! NvimTreeClose
                endif
              ]]
            end,
          },
        },
      }
    end,
  },

  -- Color scheme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
      }
    end,
  },

  -- Telescope FZF native extension
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- Telescope (fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },

  -- LSP configurations
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim', -- LSP installer
      'williamboman/mason-lspconfig.nvim',
    },
  },

  -- null-ls for formatting and linting
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Treesitter for syntax highlighting and code parsing
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'lua', 'rust', 'python', 'javascript', 'html', 'css', 'json', 'yaml' },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      }
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
      'hrsh7th/cmp-nvim-lsp', -- LSP completions
      'rafamadriz/friendly-snippets', -- Predefined snippets
    },
  },

  -- Terminal integration
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
        open_mapping = [[<C-\>]],
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          winblend = 25,
        },
      }
    end,
  },

  -- Which-key for keybinding hints
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end,
  },

  -- Autopairs for automatic closing of brackets and quotes
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  -- Enhanced command-line completion
  {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require 'wilder'
      wilder.setup { modes = { ':', '/', '?' } }

      -- Use a more advanced renderer
      wilder.set_option(
        'renderer',
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
          border = 'rounded',
          highlights = {
            border = 'Normal',
          },
          highlighter = wilder.basic_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      )
    end,
  },

  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- Diffview for git diffs
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local actions = require 'diffview.actions'

      require('diffview').setup {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = true, -- Use enhanced highlighting for diffs
        use_icons = true, -- Requires nvim-web-devicons
        keymaps = {
          view = {
            ['<leader>dq'] = actions.close, -- Close the diffview
            ['<leader>dr'] = actions.revert_buf, -- Revert changes in the current buffer
          },
          file_panel = {
            ['<leader>dr'] = actions.restore_entry, -- Restore entry in the file panel
          },
          file_history_panel = {
            ['<leader>dr'] = actions.restore_entry, -- Restore entry in the file history panel
          },
        },
      }
    end,
  },

  -- GitHub Copilot integration
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  -- Startup screen
  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },

  -- Git integration
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git diff' })
    end,
  },

  -- Undotree for visualizing undo history
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      dap.adapters.python = {
        type = 'executable',
        command = '/usr/bin/python3',
        args = { '-m', 'debugpy.adapter' },
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = function()
            return '/usr/bin/python3'
          end,
        },
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
    end,
  },

  -- **Avante.nvim Integration**
  {
    'yetone/avante.nvim',
    lazy = false,
    version = false, -- Always pull the latest changes
    build = 'make', -- Build command for avante.nvim
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'zbirenbaum/copilot.lua',
      -- Optional dependencies
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    opts = {
      -- Add any avante.nvim specific options here
      provider = 'claude', -- Use Claude AI
      auto_suggestions_provider = 'claude',
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
    },
    config = function()
      require('avante').setup {
        -- Add any avante.nvim specific options here
      }
    end,
  },
}

-- Keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Diffview keybindings
vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewOpen<CR>', { desc = 'Open Diffview' })
vim.keymap.set('n', '<leader>dx', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview' })
vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory<CR>', { desc = 'View File History' })

-- General keybindings
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' })

-- Telescope keybindings
local builtin = require 'telescope.builtin'
map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
-- Formatting keybinding
map('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format code' })

-- Undotree toggle
map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle Undotree' })

-- **Avante.nvim Keybindings**
-- Sidebar toggle
map('n', '<leader>aa', '<cmd>AvanteToggle<CR>', { desc = 'Avante: Toggle Sidebar' })

-- LSP keybindings
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover information' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to window right' })

-- Global focus change
function _G.change_focus()
  if vim.fn.winnr '$' > 1 then
    vim.cmd 'wincmd w'
  elseif vim.fn.tabpagenr '$' > 1 then
    vim.cmd 'tabnext'
  else
    vim.cmd 'bnext'
  end
end

map('n', '<leader><Tab>', '<cmd>lua change_focus()<CR>', { desc = 'Change focus globally' })

-- Formatting keybinding
map('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format code' })

-- Undotree toggle
map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle Undotree' })

-- **Avante.nvim Keybindings**
-- Sidebar toggle
map('n', '<leader>aa', '<cmd>AvanteToggle<CR>', { desc = 'Avante: Toggle Sidebar' })
-- Refresh sidebar
map('n', '<leader>ar', '<cmd>AvanteRefresh<CR>', { desc = 'Avante: Refresh Sidebar' })
-- Edit selected blocks
map('v', '<leader>ae', '<cmd>AvanteEdit<CR>', { desc = 'Avante: Edit Selected Blocks' })
-- Conflict resolution keybindings
map('n', 'co', '<cmd>AvanteConflictChooseOurs<CR>', { desc = 'Avante: Choose Ours' })
map('n', 'ct', '<cmd>AvanteConflictChooseTheirs<CR>', { desc = 'Avante: Choose Theirs' })
map('n', 'ca', '<cmd>AvanteConflictChooseAllTheirs<CR>', { desc = 'Avante: Choose All Theirs' })
map('n', 'c0', '<cmd>AvanteConflictChooseNone<CR>', { desc = 'Avante: Choose None' })
map('n', 'cb', '<cmd>AvanteConflictChooseBoth<CR>', { desc = 'Avante: Choose Both' })
map('n', 'cc', '<cmd>AvanteConflictChooseCursor<CR>', { desc = 'Avante: Choose Cursor' })
map('n', ']x', '<cmd>AvanteConflictNext<CR>', { desc = 'Avante: Next Conflict' })
map('n', '[x', '<cmd>AvanteConflictPrev<CR>', { desc = 'Avante: Previous Conflict' })
-- Jump between codeblocks
map('n', ']]', '<cmd>AvanteJumpNext<CR>', { desc = 'Avante: Jump to Next Codeblock' })
map('n', '[[', '<cmd>AvanteJumpPrev<CR>', { desc = 'Avante: Jump to Previous Codeblock' })

-- Custom autocommands
local augroup = vim.api.nvim_create_augroup('CustomAutocommands', { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})

-- LSP and Mason setup
require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua LSP
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      format = {
        enable = true,
      },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

-- Rust Analyzer
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}

-- Pyright (Python LSP)
lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- null-ls setup for formatting and linting
local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    -- Formatting sources
    null_ls.builtins.formatting.prettier, -- For JavaScript, TypeScript, HTML, CSS, etc.
    null_ls.builtins.formatting.stylua, -- For Lua
    null_ls.builtins.formatting.black, -- For Python

    -- Diagnostics (Linting) sources
    null_ls.builtins.diagnostics.eslint_d, -- For JavaScript, TypeScript
    null_ls.builtins.diagnostics.flake8, -- For Python
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    -- Adjusted <Tab> mapping
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
}

-- Integration with nvim-autopairs
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- ColorScheme adjustments for transparency
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'NONE' })
  end,
})

-- Autoformat on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- **Load ANTHROPIC_API_KEY from ~/.zshrc**
local function load_anthropic_api_key()
  local zshrc = os.getenv 'HOME' .. '/.zshrc'
  local file = io.open(zshrc, 'r')
  if file then
    for line in file:lines() do
      local key = line:match '^%s*export%s+ANTHROPIC_API_KEY%s*=%s*"(.-)"%s*$'
      if not key then
        key = line:match "^%s*export%s+ANTHROPIC_API_KEY%s*=%s*'(.-)'%s*$"
      end
      if not key then
        key = line:match '^%s*export%s+ANTHROPIC_API_KEY%s*=%s*(%S+)%s*$'
      end
      if key then
        vim.env.ANTHROPIC_API_KEY = key
        break
      end
    end
    file:close()
  end
end
load_anthropic_api_key()

-- **Load avante_lib**
require('avante_lib').load()

print 'Neovim configuration loaded successfully!'
