--TODO: investigate
--
--xmonad-docs xmonad-contrib
-- scratchpad
-- ezconfig
-- cycleRecentWS
-- xmonad docs extending
-- hintedTile

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad

import XMonad.Actions.CycleRecentWS
import XMonad.Actions.WindowGo

import XMonad.Layout.DragPane
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.MultiToggle
import XMonad.Layout.Reflect
import XMonad.Layout.DecorationMadness
import XMonad.Layout.NoBorders (smartBorders)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.StackSet as S

import Graphics.X11.ExtraTypes.XF86

myTerminal = "terminator"
--myScratchpadTerminal = "urxvt"
myScratchpadTerminal = "st"
myModMask = mod4Mask

-- vivaldi-snapshot
myBrowser = "vivaldi-stable"

-- ranger
myFileManager = "mc"

------------------------------
-- General layout
------------------------------

mySpacingWidth = 4
myBorderWidth = 3
myFocusedBorderColor = "#BBFF00"
myNormalBorderColor = "#778877"

workspace1 = "1:\xf121" -- Code
workspace2 = "2:\xf02d" -- Stuff

myLayoutHook = spacingWithEdge mySpacingWidth
  $ smartBorders
  $ avoidStruts
  $ mkToggle (single REFLECTX)
  $ mkToggle (single REFLECTY)
  $ tall
  ||| Mirror tall
  --- ||| dragPane Horizontal 0.1 0.5
  ||| tallSimpleDecoResizable
  ||| Full
  --- ||| simpleTabbed
  where
    tall = Tall 1 0.03 0.5

-- TODO: workspaces 9..16 for 'minimised' windows
myWorkspaces =
  [workspace1
  ,workspace2
  ,"3:"
  , "4:"
  ] ++ map show [5..8]

myKeys =
  -- Layout manipulatiom
  [(("M4-["), sendMessage $ Toggle REFLECTX)
  ,(("M4-]"), sendMessage $ Toggle REFLECTY)
  ,(("M4-\\"), sendMessage $ ToggleStruts)

  -- OS Misc
  ,(("M4-r"), spawn "dmenu")
  --,(("M4-r"), spawn "rofi -show run")
	,(("M4-`"), scratchpadSpawnActionTerminal myScratchpadTerminal)
  --,(("M4-M1-L"), runOrRaise "lock" (className =? "i3lock"))
  --,(("m4-shift-L"), spawn "notify-send locking")

  -- Multimedia keys
  ,(("<XF86MonBrightnessUp>"), spawn "light -inc 5")
  ,(("<XF86MonBrightnessDown>"), spawn "light -dec 5")
  ,(("C-<XF86MonBrightnessUp>"), spawn "light -max")
  ,(("C-<XF86MonBrightnessDown>"), spawn "light -min")
  ,(("<XF86AudioLowerVolume>"), spawn "amixer set Master 5%-")
  ,(("<XF86AudioRaiseVolume>"), spawn "amixer set Master 5%+")
  ,(("C-<XF86AudioLowerVolume>"), spawn "amixer set Master 1%")
  ,(("C-<XF86AudioRaiseVolume>"), spawn "amixer set Master 100%")

  ,(("<Print>"), spawn "shutter -f") -- capture entire screen
  ,(("M1-<Print>"), spawn "shutter -a") -- capture active window
  ,(("M4-<Print>"), spawn "shutter --section") -- dialog

  ,(("<XF86AudioPlay>"), spawn "notify-send play")
  ,(("<XF86AudioPause>"), spawn "notify-send pause") -- not used on XPS13?
  ,(("<XF86AudioPrev>"), spawn "notify-send back")
  ,(("<XF86AudioNext>"), spawn "notify-send forward")
  ,(("<XF86Search>"), spawn "notify-send search")

  -- TODO: lock (and load screensaver maybe?)

  -- TODO: explicit hard exit binding
  --,(("M4-S-C", kill)
  --,(("M4-S-Q", io (exitWith ExitSuccess))
  --,(("M4-S-Q", spawn "notify-send quitting ok"))
	]

myManageHook = manageDocks <+> manageScratchPad
manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.4     -- terminal height, 20%
    w = 0.6       -- terminal width, 90%
    t = 0   -- distance from top edge, 0%
    l = (1 - w) * 0.5   -- distance from left edge

myConfig = desktopConfig
  { terminal = myTerminal
  , modMask = myModMask

 -- TODO: handleEventHook
 -- TODO: LogHOok

  , borderWidth = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myNormalBorderColor

  , layoutHook = myLayoutHook
  , workspaces = myWorkspaces
  , manageHook = myManageHook
  } `additionalKeysP` myKeys

--  `additionalKeysP`
--  [ ("M-r", )
--  , ("M-S-k", kill)
--  , ("M-d", sinkAll)
--  , ("M-.", focusUrgent)
--  , ("M-,", clearUrgents)
--  ]

main = do
    spawn "~/bin/reui"
    xmonad $ myConfig
