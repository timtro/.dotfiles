local function setup()
  vim.opt.background = 'dark'
  local colors = {
    vertsplit = '#181A1F',
    special_grey = '#3B4048',
    menu_grey = '#3E4452',
    cursor_grey = '#2C323C',
    gutter_fg_grey = '#4B5263',
    blue = '#82b1ff',
    dark_red = '#BE5046',
    white = '#bfc7d5',
    green = '#C3E88D',
    purple = '#c792ea',
    yellow = '#ffcb6b',
    light_red = '#ff869a',
    red = '#ff5370',
    dark_yellow = '#F78C6C',
    cyan = '#89DDFF',
    comment_grey = '#697098',
    black = '#292D3E',
  }

  require('colors.util').set_rainbow {
    colors.gutter_fg_grey,
    colors.blue,
    colors.green,
    colors.yellow,
    colors.purple,
    colors.dark_yellow,
    colors.cyan,
    colors.red,
    colors.dark_red,
  }

  vim.cmd 'colorscheme palenight'
end

return { setup = setup, status_theme = 'palenight' }
