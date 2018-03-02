import XMonad
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP, removeKeys)
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.ManageHook
import XMonad.Layout.NoBorders
import XMonad.StackSet as StackSet
import System.Exit

main = xmonad =<< statusBar myBar myPP toggleGapsKey myConfig

myStartupHook = do
  spawn "xsetroot -cursor_name left_ptr" -- Get rid of nasty X curosr.
  spawn "compton -b"
  spawn "~/.dotfiles/xmonad/XmonadStartup.sh"
  spawn "setxkbmap -option compose:ralt"
  spawn "xautolock -corners 00-- -time 10 -locker \"gnome-screensaver-command -l\" -notify 10 -notifier \"notify-send -t 5000 -i gtk-dialog-info \'Locking in 10 seconds\'\""
  spawn "xrdb -merge /home/timtro/.dotfiles/colours/Xresources/tpixel"

myConfig = defaultConfig {
    modMask            = mod4Mask -- Use Super instead of Alt
  , startupHook        = myStartupHook
  , layoutHook         = smartBorders $ spacing 5 $ layoutHook defaultConfig
  , logHook            = fadeInactiveLogHook 0.9
  , handleEventHook    = fullscreenEventHook
  , manageHook         = namedScratchpadManageHook scratchpads
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
  , ("M-<XF86AudioNext>"     , spawn "variety --next" )
  , ("M-<XF86AudioPrev>"     , spawn "variety --previous" )
  , ("M-S-<XF86AudioPlay>"   , spawn "variety --favorite" )
  , ("M-S-<XF86AudioStop>"   , spawn "variety --trash" )
  , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 6" )
  , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 6" )
  , ("<XF86AudioMute>"       , spawn "pulseaudio-ctl mute" )
  , ("<XF86AudioPlay>"       , spawn "mocp --toggle-pause" )
  , ("<XF86AudioStop>"       , spawn "mocp --stop" )
  , ("<XF86AudioPrev>"       , spawn "mocp --previous" )
  , ("<XF86AudioNext>"       , spawn "mocp --next" )
  , ("M-`", namedScratchpadAction scratchpads "term")
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

scratchpads = [
    NS "term" "urxvt -name scratchterm" (resource =? "scratchterm")defaultFloating
  ]
