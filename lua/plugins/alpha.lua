-- lua/plugins/alpha.lua

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[     ███╗   ██╗ ██████╗ ██╗   ██╗     ]],
  [[     ████╗  ██║██╔═══██╗██║   ██║     ]],
  [[     ██╔██╗ ██║██║   ██║██║   ██║     ]],
  [[     ██║╚██╗██║██║   ██║╚██╗ ██╔╝     ]],
  [[     ██║ ╚████║╚██████╔╝ ╚████╔╝      ]],
  [[     ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝       ]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
  dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.val = "Welcome to Neovim!"

-- Set highlight groups
dashboard.section.header.opts.hl = "Type"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Function"

-- Assemble the layout
dashboard.opts.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  dashboard.section.footer,
}

alpha.setup(dashboard.opts)
