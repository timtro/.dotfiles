import XMonad
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import System.Exit
import XMonad.Hooks.DynamicLog

main = xmonad =<< statusBar myBar myPP toggleGapsKey myConfig

myStartupHook = do
  spawnOnce "/home/timtro/.screenlayout/default.sh"
  spawn "xsetroot -cursor_name left_ptr"
  spawnOnce "compton -b"
  spawn "/home/timtro/scr/wallpaper-shuffle.sh"
  spawn "/usr/bin/stalonetray"
  spawnOnce "insync start"

myConfig = defaultConfig {
  modMask = mod4Mask, -- Use Super instead of Alt
  startupHook = myStartupHook,
  layoutHook = spacing 10 $ Tall 1 (3/100) (1/2),
  terminal = "gnome-terminal",
  borderWidth = 1,
  normalBorderColor = "#181715",
  focusedBorderColor = "#58C5F1"
} `additionalKeys` myKeys `removeKeys` [(mod4Mask, xK_q)]


myKeys = 
  [
    ((mod4Mask .|. shiftMask, xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"),
    ((mod4Mask .|. shiftMask, xK_w), spawn "/home/timtro/scr/wallpaper-shuffle.sh")
  ]

myBar = "xmobar /home/timtro/.xmonad/xmobarrc"

myPP = xmobarPP { ppCurrent = xmobarColor "#181715" "#58C5F1" . wrap "[" "]",
                  ppTitle = xmobarColor "#14FF08" "" . shorten 120,
                  ppVisible = xmobarColor "#58C5F1" "#181715" . wrap "(" ")",
                  ppUrgent = xmobarColor "#181715" "#D81816",
                  ppHidden = xmobarColor "#58C5F1" "#181715",
                  ppSep = " * "
           }

-- keybinding for toggling the gap for the statusbar
toggleGapsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)