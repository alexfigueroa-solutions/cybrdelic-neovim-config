-- plugins.lua

-- Install and set up lazy.nvim plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- Clone lazy.nvim if it's not installed
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- Latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup using lazy.nvim
require('lazy').setup({
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
      require('neo-tree').setup({
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
              vim.cmd([[
                if exists('b:neo_tree_source') && b:neo_tree_source == "filesystem"
                  silent! NvimTreeClose
                endif
              ]])
            end,
          },
        },
      })
    end,
  },

  -- Color schemes
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
  },
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
  },
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
  },
  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
  },
  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
  },
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = false,
    priority = 1000,
  },
  {
    'bluz71/vim-nightfly-colors',
    name = 'nightfly',
    lazy = false,
    priority = 1000,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'tokyonight',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 1,
            },
            {
              function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end,
              icon = ' LSP:',
              color = { fg = '#ffffff', gui = 'bold' },
            },
          },
        },
      })
    end,
  },

  -- Telescope FZF native extension
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- fzf-lua for fuzzy finding
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('fzf-lua').setup({})
    end,
  },

  -- Telescope (fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
    },
  },

  -- nui.nvim for better UI components
  {
    'MunifTanjim/nui.nvim',
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
          },
          file_ignore_patterns = { 'node_modules', '.git' },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })
      pcall(telescope.load_extension, 'fzf')
    end,
  },

  -- LSP configurations
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim', -- LSP installer
      'williamboman/mason-lspconfig.nvim',
      'folke/trouble.nvim', -- Better diagnostic display
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
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'bash', 'c', 'lua', 'rust', 'python', 'javascript', 'typescript', 'html', 'css', 'json', 'yaml', 'go', 'markdown', 'vim' },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
      })
    end,
  },
  -- Treesitter playground for inspecting syntax trees
  {
    'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- Hop (Easy motion)
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require('hop').setup()
    end,
  },

  -- Better code folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('ufo').setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds = { 'imports', 'comment' },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0,
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']',
          },
        },
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
      vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end,
  },

  -- Symbol outline
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
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
      require('toggleterm').setup({
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
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
        },
      })

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { noremap = true, silent = true })
    end,
  },

  -- Which-key for keybinding hints
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({})
    end,
  },

  -- Autopairs for automatic closing of brackets and quotes
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- Multi-cursor editing
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- Better comment management
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  -- Enhanced command-line completion
  {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })

      -- Use a more advanced renderer
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          border = 'rounded',
          highlights = {
            border = 'Normal',
          },
          highlighter = wilder.basic_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      ))
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
      local actions = require('diffview.actions')

      require('diffview').setup({
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = true, -- Use enhanced highlighting for diffs
        use_icons = true, -- Requires nvim-web-devicons
        keymaps = {
          view = {
            ['<leader>dq'] = actions.close, -- Close the diffview
          },
          file_panel = {
            ['<leader>dr'] = actions.restore_entry, -- Restore entry in the file panel
          },
          file_history_panel = {
            ['<leader>dr'] = actions.restore_entry, -- Restore entry in the file history panel
          },
        },
      })
    end,
  },

  -- GitHub Copilot integration
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- Project-wide search and replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
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
    priority = 1000,
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      alpha.setup(dashboard.config)

      -- Disable folding on alpha buffer
      vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
      ]])
    end,
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    config = function()
      -- Keybinding for toggling markdown preview
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })
        end,
      })
    end,
  },

  -- Session management
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup({
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = nil,
        auto_session_use_git_branch = nil,
        -- the configs below are lua only
        bypass_session_save_file_types = nil,
      })
    end,
  },

  -- SJ (Search and Jump)
  {
    'woosaaahh/sj.nvim',
    config = function()
      local sj = require('sj')
      sj.setup({
        prompt_prefix = '/',
        highlights = {
          SjFocusedLabel = { bold = false, italic = false, fg = '#FFFFFF', bg = '#C000C0' },
          SjLabel = { bold = true, italic = false, fg = '#000000', bg = '#5AA5DE' },
          SjLimitReached = { bold = true, italic = false, fg = '#000000', bg = '#DE945A' },
          SjMatches = { bold = false, italic = false, fg = '#DDDDDD', bg = '#005080' },
          SjNoMatches = { bold = false, italic = false, fg = '#DE945A' },
          SjOverlay = { bold = false, italic = false, fg = '#345576' },
        },
        keymaps = {
          send_to_qflist = '<C-q>', --- send search result to the quickfix list
        },
      })
    end,
  },

  -- Themery for theme management
  {
    'zaldih/themery.nvim',
    config = function()
      require('themery').setup({
        themes = {
          {
            name = 'TokyoNight',
            colorscheme = 'tokyonight-night',
          },
          {
            name = 'Oxocarbon',
            colorscheme = 'oxocarbon',
          },
          {
            name = 'Gruvbox',
            colorscheme = 'gruvbox',
          },
          {
            name = 'Nord',
            colorscheme = 'nord',
          },
          {
            name = 'Catppuccin',
            colorscheme = 'catppuccin',
          },
          {
            name = 'OneDark',
            colorscheme = 'onedark',
          },
          {
            name = 'Kanagawa',
            colorscheme = 'kanagawa',
          },
          {
            name = 'Nightfox',
            colorscheme = 'nightfox',
          },
          {
            name = 'Everforest',
            colorscheme = 'everforest',
          },
          {
            name = 'Sonokai',
            colorscheme = 'sonokai',
          },
          {
            name = 'Edge',
            colorscheme = 'edge',
          },
          {
            name = 'Github',
            colorscheme = 'github_dark',
          },
          {
            name = 'Material',
            colorscheme = 'material',
          },
          {
            name = 'Dracula',
            colorscheme = 'dracula',
          },
          {
            name = 'RosePine',
            colorscheme = 'rose-pine',
          },
          {
            name = 'Moonfly',
            colorscheme = 'moonfly',
          },
          {
            name = 'Nightfly',
            colorscheme = 'nightfly',
          },
        },
        livePreview = true,
      })
    end,
  },

  -- Transparent background
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = function()
      require('transparent').setup({
        extra_groups = {
          'NormalFloat',
          'NvimTreeNormal',
          'NeoTreeNormal',
        },
        exclude_groups = {},
      })

      -- Clear specific plugin prefixes
      require('transparent').clear_prefix('BufferLine')
      require('transparent').clear_prefix('lualine')
    end,
  },

  -- GitHub integration
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup({
        default_remote = { 'upstream', 'origin' }, -- order to try remotes
        ssh_aliases = {}, -- SSH aliases
        reaction_viewer_hint_icon = '', -- marker for user reactions
        user_icon = ' ', -- user icon
        timeline_marker = '', -- timeline marker
        timeline_indent = '2', -- timeline indentation
        right_bubble_delimiter = '', -- bubble delimiter
        left_bubble_delimiter = '', -- bubble delimiter
        github_hostname = '', -- GitHub Enterprise host
        snippet_context_lines = 4, -- number of lines around commented lines
        file_panel = {
          size = 10, -- changed files panel rows
          use_icons = true, -- use web-devicons in file panel
        },
        mappings = {
          -- Mappings are provided in the previous code
          -- You can customize them as per your preference
        },
      })
    end,
  },

  -- Go development plugins
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-go').setup()
    end,
  },
  {
    'olexsmir/gopher.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('gopher').setup()
    end,
  },
  {
    'fatih/vim-go',
    ft = { 'go' },
    config = function()
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_fmt_command = 'goimports'
    end,
  },

  -- Smart-open for fast file-finding
  {
    'danielfalk/smart-open.nvim',
    branch = '0.2.x',
    config = function()
      require('telescope').load_extension('smart_open')
    end,
    dependencies = {
      'kkharji/sqlite.lua',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
    },
  },

  -- Git integration
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git diff' })
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
      vim.keymap.set('n', '<leader>gl', ':Git log<CR>', { desc = 'Git log' })
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        -- Configuration provided in the previous code
        -- You can customize it as per your preference
      })
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

  -- Minimap for code overview
  {
    'wfxr/minimap.vim',
    build = 'cargo install --locked code-minimap',
    cmd = { 'Minimap', 'MinimapClose', 'MinimapToggle', 'MinimapRefresh', 'MinimapUpdateHighlight' },
    config = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1

      -- Keybinding for toggling minimap
      vim.api.nvim_set_keymap('n', '<leader>mm', ':MinimapToggle<CR>', { noremap = true, silent = true })
    end,
  },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
      -- Debugging configuration provided in the previous code
    end,
  },
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
      provider = 'claude', -- Use Claude AI
      auto_suggestions_provider = 'claude',
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      claude = {
        api_key_name = 'ANTHROPIC_API_KEY', -- Ensure the API key name is set correctly
      },
    },
    config = function(_, opts)
      require('avante').setup(opts)
    end,
  },
})
