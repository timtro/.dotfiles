local colors = require('tokyonight.colors').setup { style = 'night' }

local function setup()
  vim.opt.background = 'dark'
  vim.g.tokyonight_style = 'night'

  require('tokyonight').setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = 'night',
    transparent = true,
    terminal_colors = true,
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value `:help attr-list`
      comments = { italic = true },
      keywords = { bold = true },
      functions = 'NONE',
      variables = {italic = true},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = 'dark', -- style for sidebars, see below
      floats = 'dark', -- style for floating windows
    },
    -- Set a darker background on sidebar-like windows.
    -- For example: `["qf", "vista_kind", "terminal", "packer"]`
    sidebars = { 'terminal', 'packer', 'help' },

    -- Enabling this option, will hide inactive statuslines and replace them
    -- with a thin border instead. Should work with the standard **StatusLine**
    -- and **LuaLine**:
    hide_inactive_statusline = false,
    dim_inactive = false, -- dims inactive windows
    -- When `true`, section headers in the lualine theme will be bold:
    lualine_bold = false,
    on_highlights = function(hl, _)
      hl.FoldColumn = {bg = 'none'}
      hl.Folded = {bg = 'none'}
      hl.BufferTabpageFill = {bg = 'none'}
      hl.BufferTabpages = {bg = 'none'}
      hl.TabLineSel = {bg = 'none'}
      hl.TabLineFill = {bg = 'none'}
      hl.StatusLine = {bg = 'none'}
      hl.BufferCurrent = {bg = 'none'}
      hl.BufferOffset = {bg = 'none'}
      hl.BufferCurrentSign = {bg = 'none'}
      hl.BufferInactive = {bg = 'none'}
      hl.BufferInactiveSign = {bg = 'none'}
      hl['@text.literal'] = {bg = 'none'}
      hl['@text.none'] = {bg = 'none'}
      hl['@text.title'] = {bg = 'none'}
      hl['BufferCurrent'] = {bg = colors.blue7}
    end
  }

  local rainbow_colors = {
    colors.fg,     -- 1
    colors.green,  -- 2
    colors.orange, -- ⋮
    colors.blue1,
    colors.yellow,
    colors.purple,
    colors.blue,
  }

  vim.cmd 'colorscheme tokyonight'
  require('colors.util').set_rainbow(rainbow_colors)
end

local lualine_theme = require 'lualine.themes.tokyonight'
lualine_theme.normal.c.bg = 'none'

return { setup = setup, status_theme = lualine_theme }
