import XMonad
import Data.Map.Strict as Map
import Data.Maybe ( fromJust )
import XMonad.Layout.NoBorders ( smartBorders, noBorders )
import XMonad.Layout.Spacing ( spacingWithEdge, incScreenWindowSpacing, setScreenWindowSpacing, toggleScreenSpacingEnabled, toggleWindowSpacingEnabled )
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiColumns
import XMonad.Layout.PerScreen
import XMonad.Util.EZConfig ( additionalKeysP, removeKeys )
import XMonad.Util.NamedScratchpad
  ( NamedScratchpad( NS )
  , customFloating
  , namedScratchpadAction
  , namedScratchpadManageHook
  )
import XMonad.Hooks.ManageDocks( ToggleStruts(ToggleStruts), Direction1D(Prev, Next), avoidStruts )
import XMonad.Hooks.DynamicLog
  ( PP
  , statusBar
  , xmobarPP
  , xmobarColor
  -- , xmobarFont
  , wrap
  , shorten
  , ppCurrent
  , ppTitle
  , ppVisible
  , ppUrgent
  , ppHidden
  , ppSep
  , ppWsSep
  )
import XMonad.Hooks.StatusBar.PP (filterOutWsPP)
import XMonad.Hooks.EwmhDesktops ( ewmh, ewmhFullscreen )
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
  config <- config_by_host hostname
  xmonad $ ewmhFullscreen . ewmh $ config

config_by_host host
  | host == "qubit"    = statusBar (xmobarCmd ++ "HD") myPP toggleGapsKey $
    allhostConfig
  | host == "positron" = statusBar (xmobarCmd ++ "UHD") myPP toggleGapsKey $
    allhostConfig
      { borderWidth = 2
      , startupHook = do
            spawn "xrandr --setprovideroutputsource modesetting NVIDIA-0"
            spawn "xrandr --auto"
            spawn "xrandr --dpi 180"
            -- Enable tap to click
            spawn "xinput --set-prop \"Synaptics TM3418-002\" \"libinput Tapping Enabled\" 1"
            -- Set touchpad speed
            spawn "xinput --set-prop \"Synaptics TM3418-002\" \"libinput Accel Speed\" 0.75"
            -- Set trackpoint speed
            spawn "xinput --set-prop \"TPPS/2 Elan TrackPoint\" \"libinput Accel Speed\" 0.7"
            allhostStartup
      , layoutHook  = myLayouts 40
      } `additionalKeysP` [
        ("M-p"                     , spawn "rofi -show combi" )
      , ("<XF86MonBrightnessUp>"   , spawn "xbacklight -inc 10" )
      , ("<XF86MonBrightnessDown>" , spawn "xbacklight -dec 10" )
      , ("<XF86Favorites>"         , spawn "xbacklight -ctrl tpacpi::kbd_backlight -inc 50" )
      , ("S-<XF86Favorites>"       , spawn "xbacklight -ctrl tpacpi::kbd_backlight -dec 50" )
      -- , ("", spawn "")
      ]
  | otherwise          = statusBar (xmobarCmd ++ "HD") myPP toggleGapsKey $
    allhostConfig
  where
    xmobarCmd = "xmobar" ++ " -B" ++ statusBg ++ " -F" ++ statusFg ++ " /home/timtro/.config/xmonad/xmobarrc."
    allhostConfig = def
      { modMask            = mod4Mask -- Use Super instead of Alt
      , startupHook        = allhostStartup
      , layoutHook         = myLayouts 20
      , handleEventHook    = handleEventHook def
      , manageHook         = myManageHook <+> namedScratchpadManageHook scratchPads
      , terminal           = "kitty"
      , borderWidth        = 1
      , normalBorderColor  = bg
      , focusedBorderColor = windowBorderColour
      , focusFollowsMouse  = False
      } `additionalKeysP` allhostKeys `removeKeys` [(mod4Mask, xK_q)]
    allhostKeys =
      [ ("M-S-r",
          spawn $ "if type xmonad; then "
              ++    "killall compton &&"
              ++    "killall picom &&"
              ++    "xautolock -exit &&"
              ++    "xmonad --recompile &&"
              ++    "xmonad --restart; "
              ++  "else"
              ++    "xmessage xmonad not in \\$PATH: \"$PATH\"; fi" )
      , ("M-S-x"                 , spawn "xkill" )
      , ("M-M1-r"                , spawn "reboot")
      , ("M-M1-p"                , spawn "shutdown -P now" )
      , ("M-S-M1-l"              , spawn $ lockerCmd )
      , ("M-p"                   , spawn "rofi -show combi" )
      , ("M-]"                   , spawn "variety --next" )
      , ("M-["                   , spawn "variety --previous" )
      , ("M-S-<Insert>"          , spawn "variety --favorite" )
      , ("M-S-<Delete>"          , spawn "variety --trash" )
      , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 6" )
      , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 6" )
      , ("<XF86AudioMute>"       , spawn "pulseaudio-ctl mute" )
      , ("<XF86AudioPlay>"       , spawn "cmus-remote --pause" )
      , ("<XF86AudioStop>"       , spawn "cmus-remote --stop" )
      , ("<XF86AudioPrev>"       , spawn "cmus-remote --prev" )
      , ("<XF86AudioNext>"       , spawn "cmus-remote --next" )
      , ("<XF86Search>"          , spawn "~/.config/xmonad/scr/display-mirror.sh" )
      , ("M-C-S-p"               , spawn "xprop > ~/xprop-`date +%X`.txt" )
      , ("M-<Print>"             , spawn "gnome-screenshot" )
      , ("M-v"                   , spawn "pavucontrol" )
      -- Scratchpads
      , ("M-`", namedScratchpadAction scratchPads "scratchTerminal")
      , ("M-f", namedScratchpadAction scratchPads "scratchFileBrowser")
      , ("M-d", namedScratchpadAction scratchPads "scratchSlack")
      , ("M-g", namedScratchpadAction scratchPads "scratchZeegaree")
      -- Gaps/spacing
      , ("M-S-="                 , incScreenWindowSpacing(5) )
      , ("M-S--"                 , incScreenWindowSpacing(-5) )
      , ("M-S-0"                 , setScreenWindowSpacing(20) )
      , ("M-M1-<Space>"          , sendMessage $ Toggle NBFULL )
      , ("M-M1-b"                , sequence_
                                    [ sendMessage ToggleStruts
                                    , sendMessage $ Toggle NBFULL] )
      , ("M-M1-h"                , sendMessage $ MirrorShrink )
      , ("M-M1-l"                , sendMessage $ MirrorExpand )
      , ("M-M1-0"                , sequence_
                                    [ toggleWindowSpacingEnabled
                                      , toggleScreenSpacingEnabled] )
      -- Keys for Binary Space Partition Layout
      -- , ("M-M1-<Left>",    sendMessage $ ExpandTowards L)
      -- , ("M-M1-<Right>",   sendMessage $ ShrinkFrom L)
      -- , ("M-M1-<Up>",      sendMessage $ ExpandTowards U)
      -- , ("M-M1-<Down>",    sendMessage $ ShrinkFrom U)
      -- , ("M-M1-C-<Left>",  sendMessage $ ShrinkFrom R)
      -- , ("M-M1-C-<Right>", sendMessage $ ExpandTowards R)
      -- , ("M-M1-C-<Up>",    sendMessage $ ShrinkFrom D)
      -- , ("M-M1-C-<Down>",  sendMessage $ ExpandTowards D)
      -- , ("M-S-C-j",        sendMessage $ SplitShift Prev)
      -- , ("M-S-C-k",        sendMessage $ SplitShift Next)
      -- , ("M-s",            sendMessage Swap)
      -- , ("M-S-s",          sendMessage Rotate)
      -- , ("M-n",            sendMessage FocusParent)
      -- , ("M-S-n",          sendMessage MoveNode)
      -- , ("M-M1-n",         sendMessage SelectNode)
      -- , ("M-a",            sendMessage Balance)
      -- , ("M-M1-a",         sendMessage Equalize)
      -- Job helpers
      , ("M-u", spawn "xdg-open /home/timtro/Documents/Standards/unimath-symbols.pdf & disown" )
      ]

allhostStartup :: X ()
allhostStartup = do
  spawn "hsetroot -solid \"#000000\""
  spawn "xsetroot -cursor_name left_ptr" -- Get rid of nasty X curosr.
  spawn "xset r rate 250 40" -- make keyboard more responsive.
  spawn "~/.config/xmonad/scr/XmonadStartup.sh"
  spawn "setxkbmap -option compose:ralt"
  spawn $ "xautolock "
              ++ "-corners 00-- "
              ++ "-time 10 "
              ++ "-locker \"" ++ lockerCmd ++ "\" -notify 10 "
              ++ "-notifier \"notify-send -t 5000 "
              ++ "-i gtk-dialog-info \'Locking in 10 seconds\'\" "
              ++ "-killtime 10 -killer \"xset dpms force off\""
  -- spawn "trayer "
  setWMName "LG3D"

-- ## Keybindings. NB: using `additionalKeysP` for Emacs style notation.
-- allhostKeys :: [( [Char], X () )]

lockerCmd :: [Char]
lockerCmd = "i3lock"
                ++ " --color 000000"
                ++ " --tiling"
                ++ " --image ~/Pictures/wallpaper/custom/lockscreen.svg.png"

-- -- Couldn't use the following because of font handling issues in xmobar.
-- -- Leaving it in, becuase maybe someday…
-- xmobarPowerlineWrap :: String -> String -> String -> String -> String -> String
-- xmobarPowerlineWrap lSymb rSymb fgColor bgColor s = wrap l r m
--   where 
--     l = xmobarColor bgColor fgColor lSymb
--     r = xmobarColor bgColor fgColor rSymb
--     m = xmobarColor fgColor bgColor (" " ++ s ++ " ")
--
-- xmobarPill :: String -> String -> String -> String
-- xmobarPill = xmobarPowerlineWrap "\xe0b6" "\xe0b4"
--
-- xmobarTab :: String -> String -> String -> String
-- xmobarTab = xmobarPowerlineWrap "\xe0bc" "\xe0be"

xmobarTile :: String -> String -> String -> String
xmobarTile fgColor bgColor = xmobarColor fgColor bgColor . wrap " " " "

blankTileBg = fromJust $ Map.lookup "bg_highlight" tokyoNightColours

myPP = xmobarPP
  { ppCurrent = xmobarTile bg blue
  , ppVisible = xmobarTile bg purple
  , ppHidden  = xmobarTile blue blankTileBg
  , ppUrgent  = xmobarTile red bg
  -- , ppWsSep   = xmobarColor fg "" " │ "
  , ppTitle   = xmobarColor windowBorderColour "" . shorten 120
  , ppSep     = xmobarColor yellow "" "   •   "
  }

  -- keybinding for toggling the gap for the statusbar
toggleGapsKey :: XConfig t -> (KeyMask, KeySym)
toggleGapsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)

-- [XMonad.ManageHook](https://goo.gl/cYgtp5)
myManageHook = composeAll
    [ isFullscreen                       --> doFullFloat
    , className =? "MPlayer"             --> doFloat
    , className =? "Insync.py"           --> doFloat
    , className =? "Variety"             --> doFloat
    , className =? "Transmission-gtk"    --> doFloat
    , className =? "Pavucontrol"         --> doFloatCornerBox
    , className =? "Scp-dbus-service.py" --> doFloatCornerBox -- Printers
    , className =? "Blueman-manager"     --> doCenterFloat
    , className =? "Blueman-assistant"   --> doCenterFloat
    , className =? "Tk"                  --> doCenterFloat
    , className =? "vlc"                 --> doCenterFloat
    , className =? "Totem"               --> doCenterFloat
    , className =? "Eog"                 --> doCenterFloat
    , className =? "Matplotlib"          --> doCenterFloat
    , className =? "Gnome-calculator"    --> doCenterFloat
    , className =? "Yad"                 --> doCenterFloat
    , className =? "Vapetick"            --> doCenterFloat
    , className =? "glslViewer"          --> doCenterFloat
    , isRole    =? "pop-up"              --> doCenterFloat
    ]
      where
        isRole = stringProperty "WM_WINDOW_ROLE"

 -- Layouts
 --
myLayouts gapWidth =
  ifWider 1500 -- Excludes Q/HD monitors in portrait
    -- If screen is wider:
    ( avoidStruts $ fullScreen ||| mkToggle (single MIRROR) (flexTallGaps) )
    -- If screen is not wider:
    ( Mirror (multiCol [1] 1 0.01 (-0.5)) )
  where
    fullScreen = spacingWithEdge 0 (noBorders Full)
    flexTallGaps = spacingWithEdge gapWidth $ ResizableTall nmaster delta ratio []
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
    delta   = 5/100


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
bg = fromJust $ Map.lookup "bg_night" tokyoNightColours

fg :: [Char]
fg = fromJust $ Map.lookup "fg" tokyoNightColours

statusBg :: [Char]
statusBg = bg
-- statusBg = fromJust $ Map.lookup "bg_blackest" tokyoNightColours

statusFg :: [Char]
statusFg = fg

red :: [Char]
red = fromJust $ Map.lookup "red" tokyoNightColours

orange :: [Char]
orange = fromJust $ Map.lookup "orange" tokyoNightColours

yellow :: [Char]
yellow = fromJust $ Map.lookup "yellow" tokyoNightColours

green :: [Char]
green = fromJust $ Map.lookup "green" tokyoNightColours

blue :: [Char]
blue = fromJust $ Map.lookup "blue" tokyoNightColours

purple :: [Char]
purple = fromJust $ Map.lookup "purple" tokyoNightColours

windowBorderColour :: [Char]
-- windowBorderColour = fromJust $ Map.lookup "dark5" tokyoNightColours
windowBorderColour = fromJust $ Map.lookup "magenta" tokyoNightColours
-- windowBorderColour = fromJust $ Map.lookup "magenta" tpixelColours

ltGreen :: [Char]
ltGreen = fromJust $ Map.lookup "green" tokyoNightColours

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

tokyoNightColours :: Map [Char] [Char]
tokyoNightColours = Map.fromList
  [  ("bg_blackest"    , "#15161E")
  ,  ("bg_night"       , "#1a1b26")
  ,  ("bg_dark"        , "#1f2335")
  ,  ("bg"             , "#24283b")
  ,  ("bg_highlight"   , "#292e42")
  ,  ("terminal_black" , "#414868")
  ,  ("fg"             , "#c0caf5")
  ,  ("fg_dark"        , "#a9b1d6")
  ,  ("fg_gutter"      , "#3b4261")
  ,  ("dark3"          , "#545c7e")
  ,  ("comment"        , "#565f89")
  ,  ("dark5"          , "#737aa2")
  ,  ("blue0"          , "#3d59a1")
  ,  ("blue"           , "#7aa2f7")
  ,  ("cyan"           , "#7dcfff")
  ,  ("blue1"          , "#2ac3de")
  ,  ("blue2"          , "#0db9d7")
  ,  ("blue5"          , "#89ddff")
  ,  ("blue6"          , "#B4F9F8")
  ,  ("blue7"          , "#394b70")
  ,  ("magenta"        , "#bb9af7")
  ,  ("magenta2"       , "#ff007c")
  ,  ("purple"         , "#9d7cd8")
  ,  ("orange"         , "#ff9e64")
  ,  ("yellow"         , "#e0af68")
  ,  ("green"          , "#9ece6a")
  ,  ("green1"         , "#73daca")
  ,  ("green2"         , "#41a6b5")
  ,  ("teal"           , "#1abc9c")
  ,  ("red"            , "#f7768e")
  ,  ("red1"           , "#db4b4b")
  ]


-- Utility functions
xmobarFont :: Int     -- ^ index: index of the font to use (0: standard font)
           -> String  -- ^ output string
           -> String
xmobarFont index = wrap ("<fn=" ++ show index ++ ">") "</fn>"
