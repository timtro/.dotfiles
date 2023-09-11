require('neorg').setup {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.keybinds'] = {},
    ['core.dirman'] = {
      config = {
        workspaces = {
          wiki = '~/Documents/neorg-wiki',
          thesis = '~/Documents/neorg-thesis',
        },
      },
    },
  },
}
