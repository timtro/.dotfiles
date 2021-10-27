return function(theme)
  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand('%:p:h')
      local gitdir = vim.fn.finddir('.git', filepath .. ';')
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  require('lualine').setup({
    options = {
      theme = theme,
      icons_enabled = true,
      -- component_separators = {left = '', right = ''},
      component_separators = '|', -- '│',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = {
        'filename',
        'branch',
        {
          'diff',
          -- symbols = { added = ' ', modified = '柳 ', removed = ' ' },
          diff_color = {
            color_added = { fg = 'DiffAdd' },
            color_modified = { fg = 'DiffChange' },
            color_removed = { fg = 'DiffDelete' },
          },
          cond = conditions.hide_in_width,
        },
      },
      lualine_c = {
        {
          function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return msg
          end,
          icon = ' LSP:',
        },
        'diagnostics',
        sources = { 'nvim_lsp' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          color_error = { fg = 'LspDiagnosticsDefaultError' },
          color_warn = { fg = 'LspDiagnosticsDefaultWarning' },
          color_info = { fg = 'LspDiagnosticsDefaultInformatio' },
        },
      },
      lualine_x = {},
      lualine_y = { 'fileformat', 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  })
end
