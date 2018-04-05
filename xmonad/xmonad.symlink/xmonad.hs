import XMonad
import XMonad.Layout.Spacing ( spacing )
import XMonad.Layout.BinarySpacePartition
import XMonad.Util.EZConfig ( additionalKeysP, removeKeys )
import XMonad.Util.NamedScratchpad (
    NamedScratchpad( NS )
  , customFloating
  , namedScratchpadAction
  , namedScratchpadManageHook )
import XMonad.Hooks.DynamicLog (
    statusBar
  , xmobarPP
  , xmobarColor
  , wrap
  , shorten
  , ppCurrent
  , ppTitle
  , ppVisible
  , ppUrgent
  , ppHidden
  , ppSep )
import XMonad.Hooks.EwmhDesktops ( ewmh, fullscreenEventHook )
import XMonad.Hooks.FadeInactive ( fadeInactiveLogHook )
import XMonad.ManageHook ( doFloat, doIgnore )
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.StackSet ( RationalRect( RationalRect ) )
import Network.HostName ( getHostName )
import XMonad.Hooks.ManageHelpers ( isFullscreen, doFullFloat )

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
  , terminal           = "urxvt"
  , borderWidth        = 1
  , normalBorderColor  = "#282828"
  , focusedBorderColor = "#d65d0e"
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
    [ className =? "MPlayer"              --> doFloat
    , className =? "Gimp"                 --> doFloat
    , className =? "Insync.py"            --> doFloat
    , className =? "Pavucontrol"          --> doFloat
    , className =? "Variety"              --> doFloat
    , className =? "Transmission-gtk"     --> doFloat
    , className =? "scp-dbus-service.py"  --> doFloat
    , isFullscreen                        --> doFullFloat
    ]

-- ## Scratchpads
--
-- [XMonad.Util.NamedScratchpad](https://goo.gl/nHveju)
-- NS is the constructor for a NamedScratchpad.
scratchPads =
  [ NS "scratchTerminal" spawnTerm  findTerm  manageTerm
  , NS "scratchFileBrowser" spawnFileBrowser findFileBrowser manageFileBrowser
  , NS "scratchSlack" spawnSlack findSlack manageSlack
  ]
  where
    spawnTerm  = "urxvt --perl-ext-common default,selection-to-clipboard,font-size,tabbed -name scratchterm1"
    findTerm   = resource  =? "scratchterm1"
    manageTerm = customFloating $ RationalRect l t w h
      where
        h = 0.512          -- height, %/100 
        w = 0.51           -- width
        t = 0.1            -- bottom edge
        l = (1 - w) - 0.05 -- left endge

    spawnFileBrowser = "nautilus --class scratchBrowser"
    findFileBrowser = className  =? "scratchBrowser"
    manageFileBrowser = auxScratchFloatRect

    spawnSlack = "slack"
    findSlack = className  =? "Slack"
    manageSlack = auxScratchFloatRect

auxScratchFloatRect = customFloating $ RationalRect l t w h
    where
      h = 1 - 2 * t      -- height, %/100 
      w = 0.51           -- width
      t = 0.05           -- bottom edge
      l = 0.05           -- left endge
