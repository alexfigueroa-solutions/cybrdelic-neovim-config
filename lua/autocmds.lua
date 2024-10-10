-- lua/autocmds.lua

-- Custom autocommands
local augroup = vim.api.nvim_create_augroup('CustomAutocommands', { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})

-- Autoformat on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Set transparency on ColorScheme
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      require('utils').set_transparency()
    end)
  end,
})

-- Markdown preview toggle (only in markdown files)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { buffer = true, desc = 'Toggle Markdown Preview' })
  end,
})

-- Go development configuration
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    -- Go specific keybindings
    vim.keymap.set('n', '<leader>gr', '<cmd>GoRun<CR>', { buffer = true, desc = 'Go Run' })
    vim.keymap.set('n', '<leader>gt', '<cmd>GoTest<CR>', { buffer = true, desc = 'Go Test' })
    vim.keymap.set('n', '<leader>gi', '<cmd>GoImpl<CR>', { buffer = true, desc = 'Go Implement' })
    vim.keymap.set('n', '<leader>gd', '<cmd>GoDef<CR>', { buffer = true, desc = 'Go to Definition' })
    vim.keymap.set('n', '<leader>gD', '<cmd>GoDoc<CR>', { buffer = true, desc = 'Go Documentation' })
    vim.keymap.set('n', '<leader>gf', '<cmd>GoFillStruct<CR>', { buffer = true, desc = 'Go Fill Struct' })
    vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<CR>', { buffer = true, desc = 'Go If Err' })
  end,
})

-- On VimEnter
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     -- Close all buffers and show Alpha dashboard
--     vim.schedule(function()
--       for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--         local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
--         if buftype ~= 'nofile' and buftype ~= 'prompt' then
--           vim.api.nvim_buf_delete(bufnr, { force = true })
--         end
--       end
--       require('alpha').start()
--       vim.cmd 'doautocmd User AlphaReady'
--     end)
--   end,
-- })
