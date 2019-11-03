import XMonad
import Data.Map.Strict as Map
import Data.Maybe ( fromJust )
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing ( spacingWithEdge, incSpacing, setSpacing, toggleScreenSpacingEnabled )
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig ( additionalKeysP, removeKeys )
import XMonad.Util.NamedScratchpad
  ( NamedScratchpad( NS )
  , customFloating
  , namedScratchpadAction
  , namedScratchpadManageHook
  )
import XMonad.Hooks.ManageDocks( ToggleStruts(ToggleStruts), Direction1D(Prev, Next) )
import XMonad.Hooks.DynamicLog
  ( PP
  , statusBar
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
-- import XMonad.Hooks.FadeInactive ( fadeInactiveLogHook )
import XMonad.Hooks.SetWMName
import XMonad.ManageHook ( doFloat, doIgnore )
import XMonad.StackSet ( RationalRect( RationalRect ) )
import Network.HostName ( getHostName )
import XMonad.Hooks.ManageHelpers
  ( isFullscreen
  , doFullFloat
  , doCenterFloat
  , doFloatAt
  , Side( SC, NC, CE, CW, SE, SW, NE, NW, C )
  , doSideFloat
  , doRectFloat
  )
import Data.Ratio

main :: IO ()
main = do
  hostname <- getHostName
  configWithBar <- statusBar (hostBarCmd hostname) myPP toggleGapsKey myConfig
  xmonad $ ewmh configWithBar

 -- The X monad, ReaderT and StateT transformers over IO encapsulating the
 --   window manager configuration and state, respectively.
 -- https://hackage.haskell.org/package/xmonad-0.13/docs/XMonad-Core.html#t:X
myStartupHook :: X ()
myStartupHook = do
  spawn "hsetroot -solid \"#000000\""
  spawn "xsetroot -cursor_name left_ptr" -- Get rid of nasty X curosr.
  -- spawn "xcompmgr -fF -I-.01 -O-.01 -D1 -r10 -o0.2"
  -- spawn "xcompmgr -cC -t-9 -l-9 -r10 -o0.75 -fF -I-.01 -O-.01 -D1"
  spawn "compton"
  spawn "~/.xmonad/scr/XmonadStartup.sh"
  spawn "setxkbmap -option compose:ralt"
  spawn $ "xautolock "
              ++ "-corners 00-- "
              ++ "-time 10 "
              ++ "-locker \"" ++ lockerCmd ++ "\" -notify 10 "
              ++ "-notifier \"notify-send -t 5000 "
              ++ "-i gtk-dialog-info \'Locking in 10 seconds\'\" "
  spawn "xrdb -merge /home/timtro/.dotfiles/colours/Xresources/dejour"
  spawn "herp"
  spawn "derp"
  setWMName "LG3D"

myConfig = defaultConfig
  { modMask            = mod4Mask -- Use Super instead of Alt
  , startupHook        = myStartupHook
  , layoutHook         = smartBorders
                          $ mkToggle (single NBFULL)
                          $ spacingWithEdge 0 (layoutHook defaultConfig ||| emptyBSP)
  -- , logHook            = fadeInactiveLogHook 0.9
  , handleEventHook    = handleEventHook def <+> fullscreenEventHook
  , manageHook         = myManageHook <+> namedScratchpadManageHook scratchPads
  , terminal           = "kitty"
  , borderWidth        = 1
  , normalBorderColor  = bg
  , focusedBorderColor = windowBorderColour
  , focusFollowsMouse  = False
  } `additionalKeysP` myKeys `removeKeys` [(mod4Mask, xK_q)]

-- ## Keybindings. NB: using `additionalKeysP` for Emacs style notation.
myKeys :: [( [Char], X () )]
myKeys =
  [ ("M-S-r",
      spawn $ "if type xmonad; then "
          ++    "killall compton &&"
          ++    "xmonad --recompile &&"
          ++    "xmonad --restart; "
          ++  "else"
          ++    "xmessage xmonad not in \\$PATH: \"$PATH\"; fi" )
  , ("M-S-x"                 , spawn "xkill" )
  , ("M-M1-r"                , spawn "reboot")
  , ("M-M1-p"                , spawn "shutdown -P now")
  , ("M-M1-l"                , spawn $ lockerCmd )
  , ("M-p"                   , spawn "rofi -show combi" )
  , ("M-<XF86AudioNext>"     , spawn "variety --next" )
  , ("M-<XF86AudioPrev>"     , spawn "variety --previous" )
  , ("M-S-<XF86AudioPlay>"   , spawn "variety --favorite" )
  , ("M-S-<XF86AudioStop>"   , spawn "variety --trash" )
  , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 6" )
  , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 6" )
  , ("<XF86AudioMute>"       , spawn "pulseaudio-ctl mute" )
  , ("<XF86AudioPlay>"       , spawn "cmus-remote --pause" )
  , ("<XF86AudioStop>"       , spawn "cmus-remote --stop" )
  , ("<XF86AudioPrev>"       , spawn "cmus-remote --prev" )
  , ("<XF86AudioNext>"       , spawn "cmus-remote --next" )
  , ("<XF86Search>"          , spawn "~/.xmonad/scr/display-mirror.sh" )
  , ("M-C-S-p"               , spawn "xprop > ~/xprop-`date +%X`.txt" )
  , ("M-<Print>"             , spawn "gnome-screenshot -i" )
  -- Scratchpads
  , ("M-`", namedScratchpadAction scratchPads "scratchTerminal")
  , ("M-f", namedScratchpadAction scratchPads "scratchFileBrowser")
  , ("M-d", namedScratchpadAction scratchPads "scratchSlack")
  , ("M-g", namedScratchpadAction scratchPads "scratchZeegaree")
  -- Gaps/spacing
  , ("M-S-="                 , incSpacing(2) )
  , ("M-S--"                 , incSpacing(-2) )
  , ("M-S-0"                 , setSpacing(10) )
  , ("M-M1-<Space>"          , sendMessage $ Toggle NBFULL )
  , ("M-M1-b"                , sequence_
                                [ sendMessage ToggleStruts
                                , sendMessage $ Toggle NBFULL
                                ])
  -- Keys for Binary Space Partition Layout
  , ("M-M1-<Left>",    sendMessage $ ExpandTowards L)
  , ("M-M1-<Right>",   sendMessage $ ShrinkFrom L)
  , ("M-M1-<Up>",      sendMessage $ ExpandTowards U)
  , ("M-M1-<Down>",    sendMessage $ ShrinkFrom U)
  , ("M-M1-C-<Left>",  sendMessage $ ShrinkFrom R)
  , ("M-M1-C-<Right>", sendMessage $ ExpandTowards R)
  , ("M-M1-C-<Up>",    sendMessage $ ShrinkFrom D)
  , ("M-M1-C-<Down>",  sendMessage $ ExpandTowards D)
  , ("M-S-C-j",        sendMessage $ SplitShift Prev)
  , ("M-S-C-k",        sendMessage $ SplitShift Next)
  , ("M-s",            sendMessage Swap)
  , ("M-S-s",          sendMessage Rotate)
  , ("M-n",            sendMessage FocusParent)
  , ("M-S-n",          sendMessage MoveNode)
  , ("M-M1-n",         sendMessage SelectNode)
  , ("M-a",            sendMessage Balance)
  , ("M-M1-a",         sendMessage Equalize)
  ]

lockerCmd :: [Char]
lockerCmd = "i3lock"
                ++ " --color 000000"
                ++ " --tiling"
                ++ " --image ~/Pictures/wallpaper/custom/lockscreen.svg.png"

-- ## Desktop bar and tray config:

hostBarCmd :: String -> String
-- export xmobar command with rc based on host's name.
hostBarCmd host
  | host == "photon"      = baseCmd ++ "laptop"
  | host == "qubit"       = baseCmd ++ "desktop"
  | host == "johnny5"     = baseCmd ++ "desktop"
  | otherwise             = baseCmd ++ "desktop"
  where
    baseCmd = "xmobar /home/timtro/.dotfiles/xmonad/xmonad.symlink/xmobarrc."

-- [xmobarPP](https://goo.gl/8djnRu)
myPP :: XMonad.Hooks.DynamicLog.PP
myPP = xmobarPP
  { ppCurrent = xmobarColor blue "" . wrap "[" "]"
  , ppTitle   = xmobarColor windowBorderColour "" . shorten 120
  , ppVisible = xmobarColor blue "" . wrap "(" ")"
  , ppUrgent  = xmobarColor red ""
  , ppHidden  = xmobarColor blue ""
  , ppSep     = xmobarColor yellow "" "  •  "
  }

  -- keybinding for toggling the gap for the statusbar
toggleGapsKey :: XConfig t -> (KeyMask, KeySym)
toggleGapsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)

-- [XMonad.ManageHook](https://goo.gl/cYgtp5)
myManageHook = composeAll
    [ isFullscreen                        --> doFullFloat
    , className =? "MPlayer"              --> doFloat
    , className =? "Gimp-2.8"             --> doFloat
    , className =? "Insync.py"            --> doFloat
    , className =? "Variety"              --> doFloat
    , className =? "Transmission-gtk"     --> doFloat
    , className =? "Xmessage"             --> doFloat
    , className =? "Ekiga"                --> doFloat
    , className =? "Pavucontrol"          --> doFloatCornerBox
    , className =? "Scp-dbus-service.py"  --> doFloatCornerBox
    , className =? "Blueman-manager"      --> doCenterFloat
    , className =? "Blueman-assistant"    --> doCenterFloat
    , className =? "Tk"                   --> doCenterFloat
    , className =? "vlc"                  --> doCenterFloat
    , className =? "Totem"                --> doCenterFloat
    , className =? "Eog"                  --> doCenterFloat
    , className =? "Gnuplot"              --> doCenterFloat
    , className =? "gnuplot_qt"           --> doCenterFloat
    , className =? "Gnome-calculator"     --> doCenterFloat
    , className =? "MATLAB R2018a"        --> doCenterFloat
    , className =? "Yad"                  --> doCenterFloat
    , className =? "Qalculate-gtk"        --> doCenterFloat
    , className =? "Zeegaree.py"          --> doCenterFloat
    , isRole    =? "pop-up"               --> doCenterFloat
    , className =? "Firefox"
                  <&&> title =? "Library" --> doCenterFloat
    ]
      where
        isRole = stringProperty "WM_WINDOW_ROLE"


-- ## Scratchpads
--
-- [XMonad.Util.NamedScratchpad](https://goo.gl/nHveju)
-- NS is the constructor for a NamedScratchpad.

hMargin :: Rational
hMargin = 0.03

vMargin :: Rational
vMargin = 0.05

scratchPads :: [NamedScratchpad]
scratchPads =
  [ NS "scratchTerminal" spawnTerm  findTerm  manageTerm
  , NS "scratchFileBrowser" spawnFileBrowser findFileBrowser manageFileBrowser
  , NS "scratchSlack" spawnSlack findSlack manageSlack
  , NS "scratchZeegaree" spawnZeegaree findZeegaree manageZeegaree
  ]
  where
    spawnTerm  = "kitty --class scratchterm1"
    findTerm   = className  =? "scratchterm1"
    manageTerm = customFloating $ RationalRect l t w h
      where
        w = 0.5                        -- width, %/100
        h = 1 - 2 * vMargin            -- height, %/100
        l = 0.5 - (w - 0.5) - hMargin  -- left edge, %/100
        t = vMargin                    -- top edge, %/100

    spawnFileBrowser = "nautilus --new-window --class scratchBrowser"
    findFileBrowser = className  =? "scratchBrowser"
    manageFileBrowser = doFloatPaneLeft

    spawnSlack = "slack"
    findSlack = className  =? "Slack"
    manageSlack = doFloatPaneLeft

    spawnZeegaree = "python3 /home/timtro/git/Zeegaree/zeegaree.py"
    findZeegaree = className  =? "Zeegaree.py"
    manageZeegaree = doCenterFloat

doFloatPaneLeft :: ManageHook
doFloatPaneLeft = customFloating $ RationalRect l t w h
    where
      w = 0.51           -- width
      h = 1 - 2 * t      -- height, %/100
      l = hMargin        -- left endge
      t = vMargin        -- top edge

doFloatCornerBox :: ManageHook
doFloatCornerBox = customFloating $ RationalRect l t w h
    where
      w = 0.33                    -- width
      h = 0.33                    -- height, %/100
      l = (1 - w) - hMargin       -- left endge
      t = vMargin                 -- top edge

-- Gruvbox colours:

bg :: [Char]
bg = fromJust $ Map.lookup "bg" tpixelColours

fg :: [Char]
fg = fromJust $ Map.lookup "fg" tpixelColours

red :: [Char]
red = fromJust $ Map.lookup "red" tpixelColours

yellow :: [Char]
yellow = fromJust $ Map.lookup "yellow" tpixelColours

blue :: [Char]
blue = fromJust $ Map.lookup "blue" tpixelColours

windowBorderColour :: [Char]
windowBorderColour = fromJust $ Map.lookup "red" tpixelColours

ltGreen :: [Char]
ltGreen = fromJust $ Map.lookup "green" tpixelColours

gruvColours :: Map [Char] [Char]
gruvColours = Map.fromList
  [ ("fg"       , "#ebdbb2")
  , ("bg"       , "#282828")
  , ("dkRed"    , "#9d0006")
  , ("red"      , "#cc241d")
  , ("ltRed"    , "#fb4934")
  , ("dkGreen"  , "#79740e")
  , ("green"    , "#98971a")
  , ("ltGreen"  , "#b8bb26")
  , ("dkYellow" , "#b57614")
  , ("yellow"   , "#d79921")
  , ("ltYellow" , "#fabd2f")
  , ("dkBlue"   , "#076678")
  , ("blue"     , "#458588")
  , ("ltBlue"   , "#83a598")
  , ("dkPurple" , "#8f3f71")
  , ("purple"   , "#b16286")
  , ("ltPurple" , "#d3869b")
  , ("dkCyan"   , "#427b58")
  , ("cyan"     , "#689d6a")
  , ("ltCyan"   , "#8ec07c")
  , ("dkOrange" , "#af3a03")
  , ("orange"   , "#d65d0e")
  , ("ltOrange" , "#fe8019")
  , ("ltGrey"   , "#a89984")
  , ("bg_h"     , "#1d2021")
  , ("bg_s"     , "#32302f")
  , ("bg1"      , "#3c3836")
  , ("bg2"      , "#504945")
  , ("bg3"      , "#665c54")
  , ("bg4"      , "#7c6f64")
  , ("fg0"      , "#fbf1c7")
  , ("fg1"      , "#ebdbb2")
  , ("fg2"      , "#d5c4a1")
  , ("fg3"      , "#bdae93")
  , ("fg4"      , "#a89984")
  ]

tpixelColours :: Map [Char] [Char]
tpixelColours = Map.fromList
  [ ("fg"        , "#ebebeb")
  , ("bg"        , "#282828")
  , ("red"       , "#a92a49")
  , ("ltRed"     , "#e33962")
  , ("green"     , "#8ab544")
  , ("ltGreen"   , "#a7e346")
  , ("yellow"    , "#f39a26")
  , ("ltYellow"  , "#f1c58b")
  , ("blue"      , "#518ba3")
  , ("ltBlue"    , "#73b9d6")
  , ("magenta"   , "#9770b3")
  , ("ltMagenta" , "#c598e6")
  , ("cyan"      , "#5ba6a5")
  , ("ltCyan"    , "#82d9d8")
  , ("dkOrange"  , "#af3a03")
  , ("orange"    , "#DB622B")
  , ("ltOrange"  , "#fe8019")
  ]
