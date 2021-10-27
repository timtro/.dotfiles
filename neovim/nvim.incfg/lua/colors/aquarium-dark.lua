
local function setup()
  vim.opt.background = 'dark'
  local colors = {
    green           = '#B1DBA4',
    pink            = '#F6BBE7',
    blue            = '#B8DCEB',
    lightblue       = '#CDDBF9',
    red             = '#EBB9B9',
    lightred        = '#EAC1C1',
    yellow          = '#E6DFB8',
    lightyellow     = '#C8CCA7',
    black           = '#1A1A24',
    black1          = '#20202A',
    black2          = '#2C2E3E',
    black3          = '#313449',
    black4          = '#3d4059',
    grey            = '#63718b',
    grey1           = '#a7b7d6',
    grey2           = '#cddbf9'
  }

  local rainbow_colors = {
    colors.grey2,
    colors.blue,
    colors.green,
    colors.red,
    colors.yellow,
    colors.pink,
    colors.lightblue,
    colors.lightred,
    colors.grey,
  }
  (require'colors.rainbow_setter')(rainbow_colors)

  vim.cmd'colorscheme aquarium'
end

return { setup = setup, status_theme = 'aquarium'}
