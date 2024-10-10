-- lua/keybindings.lua

-- Which-key setup
local wk = require 'which-key'
wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = true, suggestions = 20 },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrumb = '»',
    separator = '➜',
    group = '+',
  },
  window = {
    border = 'single',
    position = 'bottom',
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = 'left',
  },
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
  show_help = true,
  triggers_blacklist = {
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

-- General Keybindings
wk.register({
  -- File Explorer (Neo-tree)
  e = { '<cmd>Neotree toggle<CR>', 'Toggle File Explorer' },
  o = { '<cmd>Neotree focus<CR>', 'Focus File Explorer' },

  -- Terminal
  ['\\'] = { '<cmd>ToggleTerm<CR>', 'Toggle Terminal' },

  -- Toggle options
  t = {
    name = 'Toggle',
    t = { ':TransparentToggle<CR>', 'Toggle Transparency' },
    s = {
      function()
        require('utils').toggle_theme()
      end,
      'Toggle Theme',
    },
    h = { ':Themery<CR>', 'Theme Selector' },
    n = { ':set nu! rnu!<CR>', 'Toggle Line Numbers' },
    w = { ':set wrap!<CR>', 'Toggle Wrap' },
  },

  -- LSP
  l = {
    name = 'LSP',
    r = { vim.lsp.buf.rename, 'Rename Symbol' },
    a = { vim.lsp.buf.code_action, 'Code Action' },
    d = { '<cmd>Telescope diagnostics bufnr=0<CR>', 'Document Diagnostics' },
    D = { '<cmd>Telescope diagnostics<CR>', 'Workspace Diagnostics' },
    i = { '<cmd>LspInfo<CR>', 'LSP Info' },
    I = { '<cmd>Mason<CR>', 'Mason Info' },
    f = { '<cmd>lua vim.lsp.buf.format { async = true }<CR>', 'Format Document' },
    h = { vim.lsp.buf.hover, 'Hover Documentation' },
  },

  -- Diagnostics navigation
  d = {
    name = 'Diagnostics',
    ['['] = { vim.diagnostic.goto_prev, 'Previous Diagnostic' },
    [']'] = { vim.diagnostic.goto_next, 'Next Diagnostic' },
    e = { vim.diagnostic.open_float, 'Show Diagnostic' },
    q = { vim.diagnostic.setloclist, 'Diagnostic List' },
  },

  -- Git
  g = {
    name = 'Git',
    s = { '<cmd>Neogit<CR>', 'Neogit Status' },
    c = { '<cmd>Neogit commit<CR>', 'Commit' },
    p = { '<cmd>Neogit push<CR>', 'Push' },
    l = { '<cmd>Neogit pull<CR>', 'Pull' },
    d = { '<cmd>Gitsigns diffthis<CR>', 'Diff' },
    b = { '<cmd>Gitsigns blame_line<CR>', 'Blame' },
  },

  -- Diffview
  diff = {
    name = 'Diffview',
    o = { '<cmd>DiffviewOpen<CR>', 'Open Diffview' },
    c = { '<cmd>DiffviewClose<CR>', 'Close Diffview' },
    h = { '<cmd>DiffviewFileHistory %<CR>', 'File History' },
    H = { '<cmd>DiffviewFileHistory<CR>', 'Project History' },
    r = { '<cmd>DiffviewRefresh<CR>', 'Refresh Diffview' },
  },

  -- Markdown Preview
  m = { ':MarkdownPreviewToggle<CR>', 'Toggle Markdown Preview' },

  -- Notes
  n = {
    name = 'Notes',
    o = {
      function()
        require('notes').open_notes()
      end,
      'Open Notes Menu',
    },
    n = {
      function()
        require('notes').create_new_note()
      end,
      'Create New Note',
    },
    r = {
      function()
        require('notes').view_recent_notes()
      end,
      'View Recent Notes',
    },
    s = {
      function()
        require('notes').search_notes_by_tag()
      end,
      'Search Notes by Tag',
    },
    t = {
      function()
        require('notes').add_tag()
      end,
      'Add Tag to Note',
    },
  },

  -- Octo (GitHub)
  o = {
    name = 'Octo',
    l = { '<cmd>Octo repo list<CR>', 'List Repositories' },
    i = { '<cmd>Octo issue list<CR>', 'List Issues' },
    p = { '<cmd>Octo pr list<CR>', 'List Pull Requests' },
    r = { '<cmd>Octo review start<CR>', 'Start Review' },
    c = { '<cmd>Octo comment add<CR>', 'Add Comment' },
  },

  -- Git Hunks (Gitsigns)
  h = {
    name = 'Git Hunks',
    s = { ':Gitsigns stage_hunk<CR>', 'Stage Hunk' },
    u = { ':Gitsigns undo_stage_hunk<CR>', 'Undo Stage Hunk' },
    r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk' },
    R = { ':Gitsigns reset_buffer<CR>', 'Reset Buffer' },
    p = { ':Gitsigns preview_hunk<CR>', 'Preview Hunk' },
    b = { ':Gitsigns blame_line<CR>', 'Blame Line' },
  },

  -- Trouble
  x = {
    name = 'Trouble',
    x = { '<cmd>TroubleToggle<CR>', 'Toggle Trouble' },
    w = { '<cmd>TroubleToggle workspace_diagnostics<CR>', 'Workspace Diagnostics' },
    d = { '<cmd>TroubleToggle document_diagnostics<CR>', 'Document Diagnostics' },
    l = { '<cmd>TroubleToggle loclist<CR>', 'Location List' },
    q = { '<cmd>TroubleToggle quickfix<CR>', 'Quickfix List' },
    r = { '<cmd>TroubleToggle lsp_references<CR>', 'LSP References' },
  },
}, { prefix = '<leader>' })

-- Navigate between Git hunks
vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    return '[c'
  else
    vim.schedule(function()
      require('gitsigns').prev_hunk()
    end)
    return '<Ignore>'
  end
end, { expr = true, desc = 'Previous Hunk' })

vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    return ']c'
  else
    vim.schedule(function()
      require('gitsigns').next_hunk()
    end)
    return '<Ignore>'
  end
end, { expr = true, desc = 'Next Hunk' })

-- Additional Keybindings

-- Move text up and down in normal mode
wk.register({
  ['<A-j>'] = { ':m .+1<CR>==', 'Move Text Down' },
  ['<A-k>'] = { ':m .-2<CR>==', 'Move Text Up' },
}, { mode = 'n', prefix = '' })

-- Move text up and down in insert mode
wk.register({
  ['<A-j>'] = { '<Esc>:m .+1<CR>==gi', 'Move Text Down' },
  ['<A-k>'] = { '<Esc>:m .-2<CR>==gi', 'Move Text Up' },
}, { mode = 'i', prefix = '' })

-- Move text up and down in visual mode
wk.register({
  ['<A-j>'] = { ":m '>+1<CR>gv=gv", 'Move Text Down' },
  ['<A-k>'] = { ":m '<-2<CR>gv=gv", 'Move Text Up' },
}, { mode = 'v', prefix = '' })

-- Stay in indent mode in visual mode
wk.register({
  ['<'] = { '<gv', 'Indent Left' },
  ['>'] = { '>gv', 'Indent Right' },
}, { mode = 'v', prefix = '' })

-- Better paste in visual mode
wk.register({
  ['p'] = { '"_dP', 'Paste without yanking' },
}, { mode = 'v', prefix = '' })

-- Insert blank line without entering insert mode
wk.register({
  ['<space>'] = {
    name = 'Blank Line',
    ['<space>'] = { 'O<Esc>', 'Insert above' },
    ['<S-space>'] = { 'o<Esc>', 'Insert below' },
  },
}, { mode = 'n', prefix = '' })

-- Quickfix list navigation
wk.register({
  ['[q'] = { ':cprev<CR>', 'Previous Quickfix' },
  [']q'] = { ':cnext<CR>', 'Next Quickfix' },
}, { prefix = '' })

-- Location list navigation
wk.register({
  ['[l'] = { ':lprev<CR>', 'Previous Location' },
  [']l'] = { ':lnext<CR>', 'Next Location' },
}, { prefix = '' })

-- Comment toggling
wk.register({
  ['/'] = {
    name = 'Comment',
    l = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', 'Toggle Line Comment' },
    ['c'] = { '<cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', 'Toggle Comment' },
  },
}, { prefix = '<leader>' })

-- Hop keybindings
wk.register({
  s = { ':HopChar2<CR>', 'Hop to Char' },
  S = { ':HopWord<CR>', 'Hop to Word' },
}, { prefix = '' })

-- DAP (Debug Adapter Protocol) keybindings
wk.register({
  d = {
    name = 'Debug',
    b = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', 'Toggle Breakpoint' },
    c = { '<cmd>lua require("dap").continue()<CR>', 'Continue' },
    i = { '<cmd>lua require("dap").step_into()<CR>', 'Step Into' },
    o = { '<cmd>lua require("dap").step_over()<CR>', 'Step Over' },
    O = { '<cmd>lua require("dap").step_out()<CR>', 'Step Out' },
    r = { '<cmd>lua require("dap").repl.toggle()<CR>', 'Toggle REPL' },
    l = { '<cmd>lua require("dap").run_last()<CR>', 'Run Last' },
    u = { '<cmd>lua require("dapui").toggle()<CR>', 'Toggle UI' },
    t = { '<cmd>lua require("dap").terminate()<CR>', 'Terminate' },
  },
}, { prefix = '<leader>' })

-- Smart Search Keybindings
wk.register({
  s = {
    name = 'Smart Search',
    f = { '<cmd>Telescope find_files<CR>', 'Find and Preview Files' },
    g = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
    b = { '<cmd>Telescope buffers<CR>', 'Find Buffers' },
    h = { '<cmd>Telescope help_tags<CR>', 'Help Tags' },
    -- Additional smart search keybindings can be added here
  },
}, { prefix = '<leader>' })

-- Save and Quit Keybindings
wk.register({
  w = {
    name = 'Write',
    w = { ':w<CR>', 'Save File' },
    q = { ':wq<CR>', 'Save and Quit' },
    Q = { ':q!<CR>', 'Quit without Saving' },
  },
}, { prefix = '<leader>' })

-- Tab Navigation Keybindings
wk.register({
  t = {
    name = 'Tab',
    n = { '<cmd>tabnext<CR>', 'Next Tab' },
    p = { '<cmd>tabprevious<CR>', 'Previous Tab' },
  },
  ['<Tab>'] = { '<cmd>tabnext<CR>', 'Next Tab' },
  ['<S-Tab>'] = { '<cmd>tabprevious<CR>', 'Previous Tab' },
}, { prefix = '<leader>' })

-- Smart Search (Ctrl+F) via Telescope
vim.keymap.set('n', '<leader>sf', function()
  local opts = {
    prompt_title = 'Smart Search',
    path_display = { 'smart' },
    word_match = '-w',
    only_sort_text = true,
    search = '',
  }

  if vim.fn.expand '%:p' ~= '' then
    opts.cwd = vim.fn.expand '%:p:h'
  end

  require('telescope.builtin').grep_string(opts)
end, { desc = 'Smart Search (Leader+sF)' })

-- Buffer Navigation
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>bQ', ':BufferLineCloseRight<CR>', { desc = 'Close Buffers to the Right' })
vim.keymap.set('n', '<leader>bq', ':BufferLineCloseLeft<CR>', { desc = 'Close Buffers to the Left' })
vim.keymap.set('n', '<leader>bn', ':BufferLinePick<CR>', { desc = 'Pick Buffer' })
