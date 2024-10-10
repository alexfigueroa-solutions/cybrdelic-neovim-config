-- init.lua

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Load settings
require 'settings'


-- Load plugins
require 'plugins'


-- Load keybindings
require 'keybindings'

-- Load LSP configurations
require 'lsp'

-- Load utility functions
require 'utils'

-- Load notes functions
require 'notes'

-- Load analysis functions
require 'analysis'

-- Load autocmds
require 'autocmds'

-- Load avante_lib (if applicable)
require('avante_lib').load()



-- Set initial colorscheme
vim.cmd.colorscheme 'tokyonight-night'
require('tokyonight').setup {
  style = 'night',
  transparent = true,
  styles = {
    sidebars = 'transparent',
    floats = 'transparent',
  },
  on_colors = function(colors)
    colors.bg = 'NONE'
    colors.bg_dark = 'NONE'
    colors.bg_float = 'NONE'
    colors.bg_highlight = 'NONE'
    colors.bg_popup = 'NONE'
    colors.bg_sidebar = 'NONE'
    colors.bg_statusline = 'NONE'
  end,
}
-- Define a user command to copy errors to the clipboard
vim.api.nvim_create_user_command('CopyErrors', function()
  require('utils').copy_errors_to_clipboard()
end, {})

-- Optionally bind a key to run the command
vim.keymap.set('n', '<leader>ce', ':CopyErrors<CR>', { desc = 'Copy all error logs to clipboard' })

-- Ensure transparency is set after colorscheme
vim.schedule(function()
  require('utils').set_transparency()
end)

-- Load ANTHROPIC_API_KEY from ~/.zshrc
require('utils').load_anthropic_api_key()
-- Command to open notes
vim.api.nvim_create_user_command('Notes', require('notes').open_notes, {})

print 'Neovim configuration loaded successfully!'
