local function old_config()
  -- TimVim-slant_relief.txt {{{
  --[[
  __/\\\\\\\\\\\\\\\____________________________/\\\________/\\\___________________________
   _\///////\\\/////____________________________\/\\\_______\/\\\___________________________
    _______\/\\\________/\\\_____________________\//\\\______/\\\___/\\\_____________________
     _______\/\\\_______\///_____/\\\\\__/\\\\\____\//\\\____/\\\___\///_____/\\\\\__/\\\\\___
      _______\/\\\________/\\\__/\\\///\\\\\///\\\___\//\\\__/\\\_____/\\\__/\\\///\\\\\///\\\_
       _______\/\\\_______\/\\\_\/\\\_\//\\\__\/\\\____\//\\\/\\\_____\/\\\_\/\\\_\//\\\__\/\\\_
        _______\/\\\_______\/\\\_\/\\\__\/\\\__\/\\\_____\//\\\\\______\/\\\_\/\\\__\/\\\__\/\\\_
         _______\/\\\_______\/\\\_\/\\\__\/\\\__\/\\\______\//\\\_______\/\\\_\/\\\__\/\\\__\/\\\_
          _______\///________\///__\///___\///___\///________\///________\///__\///___\///___\///__
  --]]
  local art = {
    path = os.getenv 'HOME'
      .. '/.dotfiles/neovim/nvim.incfg/dashboard-headers/timvim-slant_relief.txt',
    width = 97,
    height = 11,
  }
  -- }}}

  -- TimVim-bloody.txt {{{
  --[[
  --
  -- ▄▄▄█████▓ ██▓ ███▄ ▄███▓ ██▒   █▓ ██▓ ███▄ ▄███▓
  -- ▓  ██▒ ▓▒▓██▒▓██▒▀█▀ ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
  -- ▒ ▓██░ ▒░▒██▒▓██    ▓██░ ▓██  █▒░▒██▒▓██    ▓██░
  -- ░ ▓██▓ ░ ░██░▒██    ▒██   ▒██ █░░░██░▒██    ▒██
  --   ▒██▒ ░ ░██░▒██▒   ░██▒   ▒▀█░  ░██░▒██▒   ░██▒
  --   ▒ ░░   ░▓  ░ ▒░   ░  ░   ░ ▐░  ░▓  ░ ▒░   ░  ░
  --     ░     ▒ ░░  ░      ░   ░ ░░   ▒ ░░  ░      ░
  --   ░       ▒ ░░      ░        ░░   ▒ ░░      ░
  --           ░         ░         ░   ░         ░
  --                              ░
  --]]
  -- local art = {
  --   path = os.getenv 'HOME'
  --     .. '/.dotfiles/neovim/nvim.incfg/dashboard-headers/timvim-bloody.txt',
  --   width = 48,
  --   height = 11,
  -- }
  -- }}}

  vim.g.dashboard_session_directory = vim.fn.stdpath 'cache' .. '/session'
  vim.g.dashboard_preview_file = art.path
  vim.g.dashboard_preview_file_width = art.width
  vim.g.dashboard_preview_file_height = art.height
  vim.g.dashboard_preview_command = '/bin/cat'
  vim.g.dashboard_preview_pipeline = 'lolcat -F 0.3'
  vim.g.dashboard_footer_icon = '🐬 '
  vim.g.dashboard_default_executive = 'telescope'
end

local home = os.getenv 'HOME'
local db = require 'dashboard'

-- db.setup {
--   theme = 'hyper',
--   config = {
--     week_header = {
--       enable = true,
--     },
--     center = {},
--     footer = {},
--   },
-- }

db.setup {
  theme = 'doom',
  config = {
    header = function()
      return [[

  ▄▄▄█████▓ ██▓ ███▄ ▄███▓ ██▒   █▓ ██▓ ███▄ ▄███▓
  ▓  ██▒ ▓▒▓██▒▓██▒▀█▀ ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
  ▒ ▓██░ ▒░▒██▒▓██    ▓██░ ▓██  █▒░▒██▒▓██    ▓██░
  ░ ▓██▓ ░ ░██░▒██    ▒██   ▒██ █░░░██░▒██    ▒██
    ▒██▒ ░ ░██░▒██▒   ░██▒   ▒▀█░  ░██░▒██▒   ░██▒
    ▒ ░░   ░▓  ░ ▒░   ░  ░   ░ ▐░  ░▓  ░ ▒░   ░  ░
      ░     ▒ ░░  ░      ░   ░ ░░   ▒ ░░  ░      ░
    ░       ▒ ░░      ░        ░░   ▒ ░░      ░
            ░         ░         ░   ░         ░
                               ░
]]
    end,
    preview = {
      command = 'cat',
      file_path = home
        .. '/.dotfiles/neovim/nvim.incfg/dashboard-headers/timvim-slant_relief.txt',
      file_width = 97,
      file_height = 11,
    },
    center = {
      {
        icon = '  ',
        desc = 'Latest session                          ',
        shortcut = 'SPC s l',
        action = 'SessionLoad',
      },
      {
        icon = '  ',
        desc = 'Recently opened files                   ',
        action = 'DashboardFindHistory',
        shortcut = 'SPC f h',
      },
      {
        icon = '  ',
        desc = 'Find  File                              ',
        action = 'Telescope find_files find_command=rg,--hidden,--files',
        shortcut = 'SPC f f',
      },
      {
        icon = '  ',
        desc = 'File Browser                            ',
        action = 'Telescope file_browser',
        shortcut = 'SPC f b',
      },
    },
    footer = {}, --your footer
  },
}
