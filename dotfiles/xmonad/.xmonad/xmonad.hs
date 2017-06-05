--TODO: investigate
--
--xmonad-docs xmonad-contrib
-- scratchpad
-- ezconfig
-- cycleRecentWS
-- xmonad docs extending

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad

import XMonad.Actions.CycleRecentWS

import XMonad.Layout.DragPane
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.MultiToggle
import XMonad.Layout.Reflect
import XMonad.Layout.DecorationMadness

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.StackSet as S

import Graphics.X11.ExtraTypes.XF86

myScratchpadTerminal = "urxvt"
myTerminal = "terminator"
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

-- TODO: investigate
-- hintedTile

myLayoutHook = spacingWithEdge mySpacingWidth
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

-- TODO: workspaces 9..16 for minimised windows
myWorkspaces = ["1:\xf121","2:\xf02d","3:", "4:"] ++ map show [5..8]

myKeys =
	--[(("M4-l"), runOrRaise "lock" (className =? "Firefox"))

  -- Layout manipulatiom
  [(("M4-["), sendMessage $ Toggle REFLECTX)
  ,(("M4-]"), sendMessage $ Toggle REFLECTY)
  ,(("M4-\\"), sendMessage $ ToggleStruts)

  -- OS Misc
  ,(("M4-r"), spawn "rofi -show run")
	,(("M4-`"), scratchpadSpawnActionTerminal myScratchpadTerminal)

  -- Multimedia keys
  ,(("<XF86MonBrightnessUp>"), spawn "notify-send bright up")
  ,(("<XF86MonBrightnessDown>"), spawn "notify-send bright down")
  ,(("<XF86AudioLowerVolume>"), spawn "amixer set Master 5%-")
  ,(("<XF86AudioRaiseVolume>"), spawn "amixer set Master 5%+")
  ,(("C-<XF86AudioLowerVolume>"), spawn "amixer set Master 5%")
  ,(("C-<XF86AudioRaiseVolume>"), spawn "amixer set Master 100%")

  ,(("<Print>"), spawn "shutter -f") -- capture entire screen
  ,(("M1-<Print>"), spawn "shutter -a") -- capture active window
  ,(("M4-<Print>"), spawn "shutter --section") -- dialog

  ,(("<XF86AudioPlay>"), spawn "notify-send play")
  ,(("<XF86AudioPause>"), spawn "notify-send pause") -- not used on XPS13?
  ,(("<XF86AudioPrev>"), spawn "notify-send back")
  ,(("<XF86AudioNext>"), spawn "notify-send forward")
  ,(("<XF86Search>"), spawn "notify-send search")
	]

myManageHook = manageDocks <+> manageScratchPad
manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.2     -- terminal height, 20%
    w = 0.9       -- terminal width, 90%
    t = 0   -- distance from top edge, 0%
    l = 1 - w   -- distance from left edge, 0.5%

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
