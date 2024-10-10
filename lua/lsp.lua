-- lsp.lua

-- LSP and Mason setup
require('mason').setup {
  automatic_installation = true,
}
require('mason-lspconfig').setup {
  ensure_installed = {
    'lua_ls',
    'rust_analyzer',
    'pyright',
    'tsserver',
    'gopls',
    'html',
    'cssls',
    'jsonls',
    'yamlls',
    'bashls',
    'dockerls',
    'clangd',
  },
}

local lspconfig = require 'lspconfig'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set
  keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  keymap('n', 'K', vim.lsp.buf.hover, bufopts)
  keymap('n', 'gh', vim.lsp.buf.hover, bufopts) -- Alternative hover keybinding
  keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  keymap('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  keymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  keymap('n', 'gr', vim.lsp.buf.references, bufopts)
  keymap('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
  -- Document Highlighting
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
    vim.api.nvim_clear_autocmds { group = 'LspDocumentHighlight', buffer = bufnr }
    vim.api.nvim_create_autocmd('CursorHold', {
      group = 'LspDocumentHighlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'LspDocumentHighlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- CodeLens Configuration
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_augroup('LspCodeLens', { clear = false })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      group = 'LspCodeLens',
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end
end

local servers = {
  'lua_ls',
  'rust_analyzer',
  'pyright',
  'tsserver',
  'gopls',
  'html',
  'cssls',
  'jsonls',
  'yamlls',
  'bashls',
  'dockerls',
  'clangd',
}

for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  if server == 'lua_ls' then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
        },
        -- Enable codeLens
        codeLens = {
          enable = true,
        },
      },
    }
  end
  lspconfig[server].setup(opts)
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier.with { filetypes = { 'javascript', 'typescript', 'css', 'html', 'json', 'yaml', 'markdown' } },
    null_ls.builtins.formatting.black.with { extra_args = { '--fast' } },
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
