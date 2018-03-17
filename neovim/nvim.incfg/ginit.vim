" :GuiFont Hasklig:h11

if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Hasklig 11')
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
