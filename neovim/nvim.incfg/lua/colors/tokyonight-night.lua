local colors = require('tokyonight.colors').setup { style = 'night' }

local function setup()

  require('tokyonight').setup {
    style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true, bold = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights tokyonight.Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,

    cache = true, -- When set to true, the theme will be cached for better performance

    ---@type table<string, boolean|{enabled:boolean}>
    plugins = {
      -- enable all plugins when not using lazy.nvim
      -- set to false to manually enable/disable plugins
      all = package.loaded.lazy == nil,
      -- uses your plugin manager to automatically enable needed plugins
      -- currently only lazy.nvim is supported
      auto = true,
      -- add any plugins here that you want to enable
      -- for all possible plugins, see:
      --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
      -- telescope = true,
    },
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

  -- local rainbow_colors = {
  --   colors.fg,     -- 1
  --   colors.green,  -- 2
  --   colors.orange, -- ⋮
  --   colors.blue1,
  --   colors.yellow,
  --   colors.purple,
  --   colors.blue,
  -- }

  vim.cmd 'colorscheme tokyonight'
  -- require('colors.util').set_rainbow(rainbow_colors)
end

local lualine_theme = require 'lualine.themes.tokyonight'
lualine_theme.normal.c.bg = 'none'

return { setup = setup, status_theme = lualine_theme }
