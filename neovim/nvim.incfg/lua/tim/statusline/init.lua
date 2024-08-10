local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local lsp_component = {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
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
  icon = ' ',
}

local lsp_diagnostics_component = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = 'LspDiagnosticsDefaultError' },
    color_warn = { fg = 'LspDiagnosticsDefaultWarning' },
    color_info = { fg = 'LspDiagnosticsDefaultInformatio' },
  },
}

local git_component = {
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
}

local filename_component = {
  'filename',
  file_status = true, -- Displays file status (readonly status, modified status)
  newfile_status = false, -- Display new file status (new file means no write after created)
  path = 0, -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory
  -- 4: Filename and parent dir, with tilde as the home directory

  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = '[+]', -- Text to show when the file is modified.
    readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]', -- Text to show for newly created file before first write
  },
}

local buffers_component = {
  'buffers',
  show_filename_only = true, -- Shows shortened relative path when set to false.
  hide_filename_extension = false, -- Hide filename extension when set to true.
  show_modified_status = true, -- Shows indicator when the buffer is modified.

  mode = 1,
  -- 0: Shows buffer name
  -- 1: Shows buffer index
  -- 2: Shows buffer name + buffer index
  -- 3: Shows buffer number
  -- 4: Shows buffer name + buffer number

  max_length = vim.go.columns, -- Maximum width of buffers component,
  -- it can also be a function that returns
  -- the value of `max_length` dynamically.
  filetype_names = {
    TelescopePrompt = '',
    dashboard = 'Dashboard',
    packer = 'Packer',
    fzf = 'FZF',
    alpha = 'Alpha',
  }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

  -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
  use_mode_colors = false,

  symbols = {
    modified = ' ●', -- Text to show when the buffer is modified
    alternate_file = '#', -- Text to show to identify the alternate file
    directory = '', -- Text to show when the buffer is a directory
  },
}

return function(theme)
  require('lualine').setup {
    options = {
      theme = theme,
      icons_enabled = true,
      -- component_separators = {left = '', right = ''},
      component_separators = '·', -- '│',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = { left = '', right = '' },
          right_padding = 2,
        },
      },
      lualine_b = { filename_component },
      lualine_c = { lsp_diagnostics_component },
      lualine_x = {},
      lualine_y = { 'filetype', 'progress' },
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
    -- tabline = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- },
    extensions = { 'nvim-tree' },
  }
end
