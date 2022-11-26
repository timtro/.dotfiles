require('todo-comments').setup {
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = ' ', -- icon used for the sign, and in search results
      color = 'error', -- can be a hex color, or a named color (see below)
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = ' ', color = 'info' },
    HACK = { icon = ' ', color = 'warning' },
    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
    PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
    -- EDIT = { icon = '🖍', color = 'warning' },
    EDIT = { icon = '🚧', color = 'warning', alt = { 'REV' } },
    -- EDIT = { icon = '🗟',  color = 'warning', alt = { 'REV' } },
  },
}
