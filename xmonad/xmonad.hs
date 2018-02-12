import XMonad
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP, removeKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Hooks.FadeInactive
import System.Exit

main = xmonad =<< statusBar myBar myPP toggleGapsKey myConfig

myStartupHook = do
  spawn "/home/timtro/.screenlayout/default.sh"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "compton -b"
  spawn "pnmixer"
  spawn "/home/timtro/scr/wallpaper-shuffle.sh"
  spawn "/usr/bin/stalonetray"
  spawn "insync start"
  spawn "xautolock -time 7 -locker \"gnome-screensaver-command -l\" -notify 10 -notifier \"notify-send -t 5000 -i gtk-dialog-info \'Locking in 10 seconds\'\""
  spawn "xrdb -merge /home/timtro/.dotfiles/colours/Xresources/tpixel"

myConfig = defaultConfig {
    modMask            = mod4Mask -- Use Super instead of Alt
  , startupHook        = myStartupHook
  , layoutHook         = smartBorders $ spacing 5 $ Tall 1 (3/100) (1/2)
  , logHook            = fadeInactiveLogHook 0.9
  , handleEventHook    = fullscreenEventHook
  , terminal           = "urxvt"
  , borderWidth        = 1
  , normalBorderColor  = "#181715"
  , focusedBorderColor = "#58C5F1"
  , focusFollowsMouse  = False
} `additionalKeysP` myKeys `removeKeys` [(mod4Mask, xK_q)]

myKeys =
  [ ("M-S-r",
      spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi" )
  , ("M-S-l"                 , spawn "gnome-screensaver-command -l" )
  , ("M-p"                   , spawn "rofi -combi-modi run,drun -show combi" )
  , ("M-<XF86AudioPlay>"     , spawn "/home/timtro/scr/wallpaper-shuffle.sh" )
  , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 10" )
  , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 10" )
  , ("<XF86AudioMute>"       , spawn "pulseaudio-ctl mute" )
  , ("<XF86AudioPrev>"       , spawn "mocp --previous" )
  , ("<XF86AudioNext>"       , spawn "mocp --next" )
  ]

myBar = "xmobar /home/timtro/.xmonad/xmobarrc"

myPP = xmobarPP {
    ppCurrent = xmobarColor "#181715" "#58C5F1" . wrap "[" "]"
  , ppTitle   = xmobarColor "#14FF08" "" . shorten 120
  , ppVisible = xmobarColor "#58C5F1" "#181715" . wrap "(" ")"
  , ppUrgent  = xmobarColor "#181715" "#D81816"
  , ppHidden  = xmobarColor "#58C5F1" "#181715"
  , ppSep     = " * "
}

-- keybinding for toggling the gap for the statusbar
toggleGapsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)
