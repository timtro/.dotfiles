local plenary_loaded, plenary_reload = pcall(require, 'plenary.reload')
local reloader

if plenary_loaded then
  reloader = plenary_reload.reload_module
else
  reloader = require
end

PT = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return reloader(...)
end

RL = function(name)
  RELOAD(name)
  return require(name)
end

DN = function(v, cm)
  local time = os.date '%H:%M'
  local context_msg = cm or ' '
  local msg = context_msg .. ' ' .. time
  require('notify').notify(vim.inspect(v), 'INFO', {
    title = { 'Debug Output', msg },
  })
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
