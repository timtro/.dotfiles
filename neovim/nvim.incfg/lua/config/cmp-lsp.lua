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

-- cmp setup                                                                {{{1
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- { name = 'omni' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require('lspkind').presets.default[vim_item.kind]
        .. ' '
        .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
        omni = (vim.inspect(vim_item.menu):gsub('%"', '')),
      })[entry.source.name]
      return vim_item
    end,
  },
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  }),
})

-- Use buffer source for `/` and `?`
--    (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':'
--    (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
--                                                                          }}}1
-- General LSP setup                                                        {{{1
-- INFO: Turn this off when done
vim.lsp.set_log_level 'debug'

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- cf. https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local lsp_format = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      -- only use null-ls
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
    async = true,
  }
end

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
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

  if client.supports_method 'textDocument/formatting' then
    vim.keymap.set('n', '<space>f', function()
      lsp_format(bufnr)
    end, bufopts)
  end
end

local lsp_flags = {
  debounce_text_changes = 150,
}
--                                                                          }}}1
-- LSPs                                                                     {{{1
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
    -- NOTE: Prefer stylua configured in null-ls:
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
    -- null_ls.builtins.omnifunc,
  },
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}
--                                                                          }}}1

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
