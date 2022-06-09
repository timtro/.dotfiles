vim.cmd 'set completeopt=menu,menuone,noselect'

-- Setup nvim-cmp.
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    { name = 'vsnip' },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
    { name = 'path' },
  },
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
        latex_symbols = '[Latex]',
      })[entry.source.name]
      return vim_item
    end,
  },
}

-- Setup lspconfig.
-- require('lspconfig').clangd.setup {
--   capabilities = require('cmp_nvim_lsp').update_capabilities(
--     vim.lsp.protocol.make_client_capabilities()
--   ),
-- }
-- require('lspconfig').pyright.setup {
--   capabilities = require('cmp_nvim_lsp').update_capabilities(
--     vim.lsp.protocol.make_client_capabilities()
--   ),
-- }