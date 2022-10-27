require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
    border = 'rounded',
  },
}

require('mason-lspconfig').setup {
  ensure_installed = { 'ltex', 'texlab', 'clangd', 'sumneko_lua' },
  automatic_installation = true,
}

-- INFO: Turn this off when done
vim.lsp.set_log_level 'debug'

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Unused currently, but see:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
-- local lsp_formatting = function(bufnr)
--   vim.lsp.buf.format {
--     filter = function(client)
--       -- apply whatever logic you want (in this example, we'll only use null-ls)
--       return client.name == 'null-ls'
--     end,
--     bufnr = bufnr,
--   }
-- end

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- INFO: Disabled omnifun here due to collision with luatex completion.
  -- INFO: Reenable/revisit if I ever get texlab working.
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Buffer local:
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

require('lspconfig').pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

require('lspconfig').sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Prefer stylua configured in null-ls:
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end,
  flags = lsp_flags,
}

local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    -- null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.hover.dictionary,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.stylua,
  },
  capabilities = capabilities,
  flags = lsp_flags,
}

-- require'lspconfig'.tsserver.setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
-- require'lspconfig'.rust_analyzer.setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
--     -- Server-specific settings...
--     settings = {
--       ["rust-analyzer"] = {}
--     }
-- }
-- require('lspconfig').texlab.setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
-- }
