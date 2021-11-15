require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = "❯ ",
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  },
}
