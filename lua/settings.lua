-- settings.lua

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

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
