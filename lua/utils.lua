-- lua/utils.lua

local M = {}

-- Function to set transparency
function M.set_transparency()
  local groups = {
    'Normal',
    'NormalFloat',
    'NormalNC',
    'SignColumn',
    'EndOfBuffer',
    'LineNr',
    'CursorLineNr',
    'VertSplit',
    'Folded',
    'NonText',
    'SpecialKey',
    'Pmenu',
    'PmenuSbar',
    'PmenuThumb',
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
  end

  -- Additional transparency settings
  vim.opt.pumblend = 10
  vim.opt.winblend = 10

  -- Force transparency for specific colorschemes that might override it
  vim.cmd [[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
  ]]
end

-- Theme switcher function
local themes = {
  'tokyonight-night',
  'oxocarbon',
  'gruvbox',
  'nord',
  'catppuccin',
  'onedark',
  'kanagawa',
  'nightfox',
  'everforest',
  'sonokai',
  'edge',
  'github_dark',
  'material',
  'dracula',
  'rose-pine',
  'tokyonight-storm',
  'moonfly',
  'nightfly',
}
local current_theme_index = 1

function M.toggle_theme()
  current_theme_index = (current_theme_index % #themes) + 1
  local new_theme = themes[current_theme_index]
  vim.cmd.colorscheme(new_theme)
  vim.o.background = 'dark'

  if new_theme == 'tokyonight-night' then
    require('tokyonight').setup {
      style = 'night',
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    }
  elseif new_theme == 'oxocarbon' then
    -- Oxocarbon doesn't have a setup function
  elseif new_theme == 'gruvbox' then
    require('gruvbox').setup {
      transparent_mode = true,
    }
  elseif new_theme == 'nord' then
    -- Nord doesn't have a setup function
  elseif new_theme == 'catppuccin' then
    require('catppuccin').setup {
      transparent_background = true,
    }
  elseif new_theme == 'onedark' then
    require('onedark').setup {
      style = 'dark',
      transparent = true,
    }
  elseif new_theme == 'kanagawa' then
    require('kanagawa').setup {
      transparent = true,
    }
  elseif new_theme == 'nightfox' then
    require('nightfox').setup {
      transparent = true,
    }
  elseif new_theme == 'everforest' then
    vim.g.everforest_transparent_background = 1
  elseif new_theme == 'sonokai' then
    vim.g.sonokai_transparent_background = 1
  elseif new_theme == 'edge' then
    vim.g.edge_transparent_background = 1
  elseif new_theme == 'github_dark' then
    require('github-theme').setup {
      transparent = true,
    }
  elseif new_theme == 'material' then
    require('material').setup {
      contrast = {
        terminal = false,
        sidebars = false,
        floating_windows = false,
        cursor_line = false,
        non_current_windows = false,
        filetypes = {},
      },
    }
    vim.g.material_style = 'deep ocean'
  elseif new_theme == 'dracula' then
    require('dracula').setup {
      transparent_bg = true,
    }
  elseif new_theme == 'rose-pine' then
    require('rose-pine').setup {
      disable_background = true,
    }
  elseif new_theme == 'tokyonight-storm' then
    require('tokyonight').setup {
      style = 'storm',
      transparent = true,
    }
  elseif new_theme == 'moonfly' then
    vim.g.moonflyCursorColor = true
    vim.g.moonflyTransparent = true
  elseif new_theme == 'nightfly' then
    vim.g.nightflyCursorColor = true
    vim.g.nightflyTransparent = true
  end

  print('Switched to ' .. new_theme .. ' theme')
end

-- Function to load ANTHROPIC_API_KEY from ~/.zshrc
function M.load_anthropic_api_key()
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

return M
