local global_listener = 'global_listener_namespace'
local autocmdhandlers = {}

_G[global_listener] = function(name)
  autocmdhandlers[name]()
end

_G['AddEventListener'] = function(name, events, cb)
  autocmdhandlers[name] = cb
  vim.cmd('augroup ' .. name)
  vim.cmd 'autocmd!'
  for _, v in ipairs(events) do
    local cmd = 'lua ' .. global_listener .. '("' .. name .. '")'
    vim.cmd('au ' .. v .. ' ' .. cmd)
  end
  vim.cmd 'augroup end'
end

_G['RemoveEventListener'] = function(name)
  vim.cmd('augroup ' .. name)
  vim.cmd 'autocmd!'
  vim.cmd 'augroup end'
  autocmdhandlers[name] = nil
end

AddEventListener(
  'ScrolloffFraction',
  { 'BufEnter,WinEnter,WinNew,VimResized *,*.*' },
  function()
    if vim.opt.filetype ~= 'qf' then
      local vis_lines = vim.api.nvim_win_get_height(vim.fn.win_getid())
      vim.opt.scrolloff = math.floor(vis_lines * 0.25)
    end
  end
)

AddEventListener('LuaHighlight', { 'TextYankPost *' }, function()
  require('vim.highlight').on_yank()
end)

AddEventListener('DisableHighLight', { 'InsertEnter,CursorMoved *' }, function()
  vim.opt.hlsearch = false
end)
