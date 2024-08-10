return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'j-hui/fidget.nvim',
    'onsails/lspkind-nvim', -- Icons for autocompletion.
  },
  config = function()
    local lspconfig = require('lspconfig')
    require('fidget').setup({})
    require('mason').setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
        border = 'rounded',
      }
    }

    local cmp = require 'cmp'
    local cmp_lsp = require 'cmp_nvim_lsp'

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    local lsp_capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    local lsp_flags = {
      debounce_text_changes = 150,
    }

    local lsp_format = function(bufnr)
      vim.lsp.buf.format {
        -- filter = function(client)
        -- end,
        bufnr = bufnr,
        async = true,
      }
    end

    local lsp_on_attach = function(client, bufnr)
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

    require('mason-lspconfig').setup {
      ensure_installed = {
        'ltex',
        'texlab',
        'clangd',
        'lua_ls',
        'rust_analyzer',
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = lsp_capabilities,
            flags = lsp_flags,
            on_attach = lsp_on_attach,
          }
        end,
        ['lua_ls'] = function()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                }
              }
            },
            flags = lsp_flags,
            capabilities = lsp_capabilities,
            on_attach = lsp_on_attach,
          }
        end,
        ['clangd'] = function()
          require('lspconfig').clangd.setup {
            cmd = {
              'clangd-18',
              '--background-index',
              '--clang-tidy',
              '--enable-config',
              -- '--header-insertion=iwyu',
            },
            on_attach = lsp_on_attach,
            capabilities = lsp_capabilities,
            flags = lsp_flags,
          }
        end,
        ['rust_analyzer'] = function()
          lspconfig.rust_analyzer.setup({
            on_attach = lsp_on_attach,
            capabilities = lsp_capabilities,
            flags = lsp_flags,
            root_dir = require('lspconfig.util').root_pattern('Cargo.toml'),
            settings = {
              cargo = {
                allFeatures = true,
              }
            }
          })
        end,
      },
    }

    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

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
        ['<tab>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
          })[entry.source.name]
          return vim_item
        end,
      },
    }

    vim.diagnostic.config({
      virtual_text = true,
      update_in_insert = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
      },
    })

    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
      }, {
        { name = 'buffer' },
      }),
    })

    cmp.setup.filetype('tex', {
      sources = cmp.config.sources {
        -- {
        --   name = 'omni',
        --   keyword_length = 0, -- required or nothing shows.
        --   option = {
        --     disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' },
        --   },
        -- },
        { name = 'luasnip' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
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
            latex_symbols = '[LaTeX]',
            -- omni = (vim.inspect(vim_item.menu):gsub('%"', '')),
            -- omni = '[Omni]',
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- Use buffer source for `/` and `?`
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end
}
