import System.IO

import XMonad
import XMonad.Config.Desktop

import XMonad.Layout.NoBorders
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.WindowNavigation
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.BoringWindows
import XMonad.Layout.ResizableTile
import XMonad.Layout.Named
import XMonad.Layout.Simplest
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe,hPutStrLn)

import qualified XMonad.StackSet as W

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

import XMonad.Actions.NoBorders

myManageHook = composeAll [ manageHook defaultConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doFloat
    , manageDocks
    ]

tabTheme = defaultTheme { decoHeight = 20
     , activeColor = "#{{ pillar['color'] }}"
     , activeBorderColor = "#{{ pillar['color'] }}"
     , activeTextColor = "#000000"
     , inactiveTextColor = "#454545"
     , inactiveColor = "#252525"
     , inactiveBorderColor = "#252525"
     }

--myLayoutHook = windowNavigation $ addTabs shrinkText tabTheme $ boringWindows $ avoidStruts(tall) ||| noBorders Full
--    where
--      rt = ResizableTall 1 (3/100) (1/2) []
--      tall = named "Tall" $ subLayout [0,1,2] (Simplest) $ rt

myLayoutHook = avoidStruts(mouseResizableTile { masterFrac = ratio, fracIncrement = delta, nmaster = mynmaster, draggerType = BordersDragger }) ||| noBorders Full
  where
     -- The default number of windows in the master pane
     mynmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 5/10

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

selected   = "'#{{ pillar['color'] }}'"
background = "'#383a3b'" --313437
foreground = "'#ffffff'"
selectedForeground = "'#000000'" --313437
-- height matches Ubuntu top Gnome panel
barHeight = "30"

appFontXft = "'xft\
                \:Sans\
                \:pixelsize=14\
                \:weight=regular\
                \:width=semicondensed\
                \:dpi=96\
                \:hinting=true\
                \:hintstyle=hintslight\
                \:antialias=true\
                \:rgba=rgb\
                \:lcdfilter=lcdlight\
             \'"

myDmenuTitleBar =
    "exec `dmenu_path | dmenu\
        \ -i\
        \ -nb " ++ background ++ "\
        \ -nf " ++ foreground ++ "\
        \ -sb " ++ selected   ++ "\
        \ -sf " ++ selectedForeground   ++ "\
        \ -fn " ++ appFontXft ++ "\
    \`"

main = xmonad $ ewmh defaultConfig {
       layoutHook = myLayoutHook,
       manageHook = myManageHook,
       borderWidth = 6,
       logHook = setWMName "LG3D",
       focusFollowsMouse = True,
       normalBorderColor = "#383a3b",
       focusedBorderColor = "#{{ pillar['color'] }}"
    }
     -- add a screenshot key to the default desktop bindings
    `additionalKeys` [
        ((mod1Mask,                 xK_o), sendMessage ExpandSlave) -- %! Shrink a slave area
        , ((mod1Mask,               xK_i), sendMessage ShrinkSlave) -- %! Expand a slave area
        , ((mod1Mask,               xK_k), windows W.focusDown) -- %! Move focus to the next window
        , ((mod1Mask,               xK_j), windows W.focusUp) -- %! Move focus to the previous window
        , ((mod1Mask .|. shiftMask, xK_k), windows W.swapDown) -- %! Swap the focused window with the next window
        , ((mod1Mask .|. shiftMask, xK_j), windows W.swapUp) -- %! Swap the focused window with the previous window

        --, ((mod1Mask .|. controlMask, xK_Left), sendMessage $ pullGroup L)
        --, ((mod1Mask .|. controlMask, xK_Right), sendMessage $ pullGroup R)
        --, ((mod1Mask .|. controlMask, xK_Up), sendMessage $ pullGroup U)
        --, ((mod1Mask .|. controlMask, xK_Down), sendMessage $ pullGroup D)

        --, ((mod1Mask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
        --, ((mod1Mask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))

        --, ((mod1Mask .|. controlMask, xK_period), onGroup W.focusUp')
        --, ((mod1Mask .|. controlMask, xK_comma), onGroup W.focusDown')

        , ((mod1Mask,               xK_p), spawn myDmenuTitleBar)
        , ((mod1Mask,               xK_b), sendMessage ToggleStruts)
        , ((mod1Mask,               xK_d), withFocused toggleBorder)
    ]
