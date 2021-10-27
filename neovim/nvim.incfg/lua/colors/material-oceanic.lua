local function setup()
  vim.opt.background = 'dark'
  vim.g.material_style = 'oceanic'

  local material_config = {
    contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
    borders = true, -- Enable borders between verticaly split windows
    italics = {
      comments = false, -- Enable italic comments
      keywords = true, -- Enable italic keywords
      functions = false, -- Enable italic functions
      strings = false, -- Enable italic strings
      variables = false, -- Enable italic variables
    },
    contrast_windows = { -- Specify which windows get the contrasted (darker) background
      'terminal', -- Darker terminal background
      'packer', -- Darker packer background
    },
    text_contrast = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = true, -- Enable higher contrast text for darker style
    },
    disable = {
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },
    custom_highlights = {}, -- Overwrite highlights with your own
  }

  local material_colors = require('material.colors')

  vim.cmd(
    string.format(
      'highlight IndentBlanklineContextChar guifg=%s gui=nocombine cterm=nocombine',
      material_colors.blue
    )
  )

  local rainbow_colors = {
    material_colors.fg,
    material_colors.blue,
    material_colors.purple,
    material_colors.yellow,
    material_colors.green,
    material_colors.orange,
    material_colors.darkpurple,
    material_colors.darkblue,
    material_colors.darkyellow,
    material_colors.darkgreen,
    material_colors.darkorange,
  };

  (require('colors.rainbow_setter'))(rainbow_colors)

  require('material').setup(material_config)
  vim.cmd([[colorscheme material]])
end

return { setup = setup, status_theme = 'material-nvim' }
