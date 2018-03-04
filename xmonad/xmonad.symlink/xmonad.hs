import XMonad
import XMonad.Layout.Spacing (spacing)
-- import XMonad.Util.SpawnOnce 
import XMonad.Util.EZConfig (additionalKeysP, removeKeys)
import XMonad.Util.NamedScratchpad (
    NamedScratchpad( NS )
  , customFloating
  , namedScratchpadAction
  , namedScratchpadManageHook
  )
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad.ManageHook (doFloat, doIgnore)
import XMonad.Layout.NoBorders (smartBorders)
import qualified XMonad.StackSet as W
import Network.HostName (getHostName)
import System.Exit

main = do
  hostname <- getHostName
  xmonad =<< statusBar (hostBarCmd hostname) myPP toggleGapsKey myConfig

myStartupHook = do
  spawn "xsetroot -cursor_name left_ptr" -- Get rid of nasty X curosr.
  spawn "compton -b"
  spawn "~/.dotfiles/xmonad/XmonadStartup.sh"
  spawn "setxkbmap -option compose:ralt"
  spawn "xautolock -corners 00-- -time 10 -locker \"gnome-screensaver-command -l\" -notify 10 -notifier \"notify-send -t 5000 -i gtk-dialog-info \'Locking in 10 seconds\'\""
  spawn "xrdb -merge /home/timtro/.dotfiles/colours/Xresources/tpixel"

myConfig = defaultConfig
  { modMask            = mod4Mask -- Use Super instead of Alt
  , startupHook        = myStartupHook
  , layoutHook         = smartBorders $ spacing 5 $ layoutHook defaultConfig
  , logHook            = fadeInactiveLogHook 0.9
  , handleEventHook    = fullscreenEventHook
  , manageHook         = myManageHook <+> namedScratchpadManageHook scratchPads
  , terminal           = "urxvt"
  , borderWidth        = 1
  , normalBorderColor  = "#181715"
  , focusedBorderColor = "#58C5F1"
  , focusFollowsMouse  = False
  } `additionalKeysP` myKeys `removeKeys` [(mod4Mask, xK_q)]

-- ## Keybindings. NB: using `additionalKeysP` for Emacs style notation.
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
  , ("M-C-S-p"               , spawn "xprop > ~/xprop-`date +%X`.txt" )
  , ("M-`", namedScratchpadAction scratchPads "terminal")
  ]

-- ## Desktop bar and tray config:

hostBarCmd :: String -> String
-- export xmobar command with rc based on host's name.
hostBarCmd host
  | host == "photon" = baseCmd ++ "xmobarrc.moHD"
  | host == "qubit" = baseCmd ++ "xmobarrc.dt2HD"
  | host == "johnny-five" = baseCmd ++ "xmobarrc.dt2HD"
  where
    baseCmd = "xmobar /home/timtro/.dotfiles/xmonad/xmonad.symlink/"

-- [xmobarPP](https://goo.gl/8djnRu)
myPP = xmobarPP
  { ppCurrent = xmobarColor "#181715" "#58C5F1" . wrap "[" "]"
  , ppTitle   = xmobarColor "#14FF08" "" . shorten 120
  , ppVisible = xmobarColor "#58C5F1" "#181715" . wrap "(" ")"
  , ppUrgent  = xmobarColor "#181715" "#D81816"
  , ppHidden  = xmobarColor "#58C5F1" "#181715"
  , ppSep     = "  •  "
  }

  -- keybinding for toggling the gap for the statusbar
toggleGapsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)

-- [XMonad.ManageHook](https://goo.gl/cYgtp5)
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Insync.py"      --> doIgnore
    ]

-- ## Scratchpads
--
-- [XMonad.Util.NamedScratchpad](https://goo.gl/nHveju)
-- NS is the constructor for a NamedScratchpad.
scratchPads = 
  [ NS "terminal" spawnTerm  findTerm  manageTerm ]
  where
    spawnTerm  = "urxvt -name scratchterm1"
    findTerm   = resource  =? "scratchterm1"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.5            -- height, %/100 
        w = 0.5            -- width
        t = 0.1            -- bottom edge
        l = (1 - w) / 1.2  -- left endge