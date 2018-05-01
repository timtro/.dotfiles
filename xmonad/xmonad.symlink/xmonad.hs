import XMonad
import XMonad.Layout.Spacing ( spacing )
import XMonad.Layout.BinarySpacePartition
import XMonad.Util.EZConfig ( additionalKeysP, removeKeys )
import XMonad.Util.NamedScratchpad
  ( NamedScratchpad( NS )
  , customFloating
  , namedScratchpadAction
  , namedScratchpadManageHook
  )
import XMonad.Hooks.DynamicLog
  ( statusBar
  , xmobarPP
  , xmobarColor
  , wrap
  , shorten
  , ppCurrent
  , ppTitle
  , ppVisible
  , ppUrgent
  , ppHidden
  , ppSep
  )
import XMonad.Hooks.EwmhDesktops ( ewmh, fullscreenEventHook )
import XMonad.Hooks.FadeInactive ( fadeInactiveLogHook )
import XMonad.ManageHook ( doFloat, doIgnore )
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.StackSet ( RationalRect( RationalRect ) )
import Network.HostName ( getHostName )
import XMonad.Hooks.ManageHelpers
  ( isFullscreen
  , doFullFloat
  , doCenterFloat
  , doFloatAt
  , Side( SC, NC, CE, CW, SE, SW, NE, NW, C )
  , doSideFloat
  )

import Data.Ratio

main = do
  hostname <- getHostName
  configWithBar <- statusBar (hostBarCmd hostname) myPP toggleGapsKey myConfig
  xmonad $ ewmh configWithBar

myStartupHook = do
  spawn "xsetroot -cursor_name left_ptr" -- Get rid of nasty X curosr.
  spawn "xcompmgr -fF -I-.01 -O-.01 -D1"
  spawn "~/.dotfiles/xmonad/XmonadStartup.sh"
  spawn "setxkbmap -option compose:ralt"
  spawn "xautolock -corners 00-- -time 10 -locker \"gnome-screensaver-command -l\" -notify 10 -notifier \"notify-send -t 5000 -i gtk-dialog-info \'Locking in 10 seconds\'\""
  spawn "xrdb -merge /home/timtro/.dotfiles/colours/Xresources/dejour"

myConfig = defaultConfig
  { modMask            = mod4Mask -- Use Super instead of Alt
  , startupHook        = myStartupHook
  , layoutHook         = smartBorders
                          $ spacing 5 (layoutHook defaultConfig ||| emptyBSP)
  , logHook            = fadeInactiveLogHook 0.9
  , handleEventHook    = handleEventHook def <+> fullscreenEventHook
  , manageHook         = myManageHook <+> namedScratchpadManageHook scratchPads
  , terminal           = "kitty"
  , borderWidth        = 1
  , normalBorderColor  = bg
  , focusedBorderColor = dkBlue
  , focusFollowsMouse  = False
  } `additionalKeysP` myKeys `removeKeys` [(mod4Mask, xK_q)]

-- ## Keybindings. NB: using `additionalKeysP` for Emacs style notation.
myKeys =
  [ ("M-S-r",
      spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi" )
  , ("M-S-x"                 , spawn "xkill" )
  , ("M-M1-r"                , spawn "reboot")
  , ("M-M1-p"                , spawn "shutdown -P now")
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
  -- Scratchpads
  , ("M-`", namedScratchpadAction scratchPads "scratchTerminal")
  , ("M-f", namedScratchpadAction scratchPads "scratchFileBrowser")
  , ("M-d", namedScratchpadAction scratchPads "scratchSlack")
  -- Keys for Binary Space Partition Layout
  , ("M-M1-<Left>",    sendMessage $ ExpandTowards L)
  , ("M-M1-<Right>",   sendMessage $ ShrinkFrom L)
  , ("M-M1-<Up>",      sendMessage $ ExpandTowards U)
  , ("M-M1-<Down>",    sendMessage $ ShrinkFrom U)
  , ("M-M1-C-<Left>",  sendMessage $ ShrinkFrom R)
  , ("M-M1-C-<Right>", sendMessage $ ExpandTowards R)
  , ("M-M1-C-<Up>",    sendMessage $ ShrinkFrom D)
  , ("M-M1-C-<Down>",  sendMessage $ ExpandTowards D)
  , ("M-s",            sendMessage $ Swap)
  , ("M-M1-s",         sendMessage $ Rotate)
  ]

-- ## Desktop bar and tray config:

hostBarCmd :: String -> String
-- export xmobar command with rc based on host's name.
hostBarCmd host
  | host == "photon"      = baseCmd ++ "laptop"
  | host == "qubit"       = baseCmd ++ "desktop"
  | host == "johnny-five" = baseCmd ++ "desktop"
  | otherwise             = baseCmd ++ "desktop"
  where
    baseCmd = "xmobar /home/timtro/.dotfiles/xmonad/xmonad.symlink/xmobarrc."

-- [xmobarPP](https://goo.gl/8djnRu)
myPP = xmobarPP
  { ppCurrent = xmobarColor blue "" . wrap "[" "]"
  , ppTitle   = xmobarColor ltGreen "" . shorten 120
  , ppVisible = xmobarColor blue "" . wrap "(" ")"
  , ppUrgent  = xmobarColor red ""
  , ppHidden  = xmobarColor blue ""
  , ppSep     = xmobarColor yellow "" "  •  "
  }

  -- keybinding for toggling the gap for the statusbar
toggleGapsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)

-- [XMonad.ManageHook](https://goo.gl/cYgtp5)
myManageHook = composeAll
    [ className =? "MPlayer"              --> doFloat
    , className =? "Gimp"                 --> doFloat
    , className =? "Insync.py"            --> doFloat
    , className =? "Variety"              --> doFloat
    , className =? "Transmission-gtk"     --> doFloat
    , className =? "Xmessage"             --> doFloat
    , className =? "Pavucontrol"          --> doFloatCornerBox
    , className =? "Scp-dbus-service.py"  --> doFloatCornerBox
    , className =? "Colorpicker2.py"      --> doFloat
    , className =? "Colorpicker3.py"      --> doFloat
    , className =? "Blueman-manager"      --> doCenterFloat
    , className =? "Blueman-assistant"    --> doCenterFloat
    , className =? "Tk"                   --> doCenterFloat
    , className =? "vlc"                  --> doCenterFloat
    , className =? "Totem"                --> doCenterFloat
    , className =? "Eog"                  --> doCenterFloat
    , className =? "Gnuplot"              --> doCenterFloat
    , className =? "gnuplot_qt"           --> doCenterFloat
    , isFullscreen                        --> doFullFloat
    ]

-- ## Scratchpads
--
-- [XMonad.Util.NamedScratchpad](https://goo.gl/nHveju)
-- NS is the constructor for a NamedScratchpad.

hMargin = 0.03
vMargin = 0.05

scratchPads =
  [ NS "scratchTerminal" spawnTerm  findTerm  manageTerm
  , NS "scratchFileBrowser" spawnFileBrowser findFileBrowser manageFileBrowser
  , NS "scratchSlack" spawnSlack findSlack manageSlack
  ]
  where
    spawnTerm  = "kitty --class scratchterm1"
    findTerm   = className  =? "scratchterm1"
    manageTerm = customFloating $ RationalRect l t w h
      where
        w = 0.5                        -- width, %/100
        h = 0.80                       -- height, %/100
        l = 0.5 - (w - 0.5) - hMargin  -- left edge, %/100
        t = vMargin                    -- top edge, %/100

    spawnFileBrowser = "nautilus --class scratchBrowser"
    findFileBrowser = className  =? "scratchBrowser"
    manageFileBrowser = doFloatPaneLeft

    spawnSlack = "slack"
    findSlack = className  =? "Slack"
    manageSlack = doFloatPaneLeft


doFloatPaneLeft = customFloating $ RationalRect l t w h
    where
      w = 0.51           -- width
      h = 1 - 2 * t      -- height, %/100
      l = hMargin        -- left endge
      t = vMargin        -- top edge

doFloatCornerBox = customFloating $ RationalRect l t w h
    where
      w = 0.33                    -- width
      h = 0.33                    -- height, %/100
      l = (1 - w) - hMargin       -- left endge
      t = vMargin                 -- top edge

-- Gruvbox colours:
fg         = "#ebdbb2"
bg         = "#282828"
dkRed      = "#9d0006"
red        = "#cc241d"
ltRed      = "#fb4934"
dkGreen    = "#79740e"
green      = "#98971a"
ltGreen    = "#b8bb26"
dkYellow   = "#b57614"
yellow     = "#d79921"
ltYellow   = "#fabd2f"
dkBlue     = "#076678"
blue       = "#458588"
ltBlue     = "#83a598"
dkPurple   = "#8f3f71"
purple     = "#b16286"
ltPurple   = "#d3869b"
dkCyan     = "#427b58"
cyan       = "#689d6a"
ltCyan     = "#8ec07c"
dkOrange   = "#af3a03"
orange     = "#d65d0e"
ltOrange   = "#fe8019"
ltGrey     = "#a89984"
bg_h       = "#1d2021"
bg_s       = "#32302f"
bg1        = "#3c3836"
bg2        = "#504945"
bg3        = "#665c54"
bg4        = "#7c6f64"
fg0        = "#fbf1c7"
fg1        = "#ebdbb2"
fg2        = "#d5c4a1"
fg3        = "#bdae93"
fg4        = "#a89984"
