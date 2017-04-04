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

import XMonad.Actions.CycleRecentWS

import XMonad.Layout.DragPane
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.MultiToggle
import XMonad.Layout.Reflect

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
  $ tall ||| Mirror tall ||| dragPane Horizontal 0.1 0.5 ||| Full ||| simpleTabbed
  where
    tall = Tall 1 0.03 0.5

-- TODO: workspaces 9..16 for minimised windows
myWorkspaces = ["1:\xf121","2:\xf02d","3:code", "4:misc"] ++ map show [5..8]

myKeys =
	--[(("M4-l"), runOrRaise "lock" (className =? "Firefox"))
  [(("M4-["), sendMessage $ Toggle REFLECTX)
  ,(("M4-]"), sendMessage $ Toggle REFLECTY)
  ,(("M4-\\"), sendMessage $ ToggleStruts)
	,(("M4-r"), spawn "rofi -show run")
	]


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
  } `additionalKeysP` myKeys

--  `additionalKeysP`
--  [ ("M-r", )
--  , ("M-S-k", kill)
--  , ("M-d", sinkAll)
--  , ("M-.", focusUrgent)
--  , ("M-,", clearUrgents)
--  ]

main = do
  --  spawn "bash ~/.xmonad/startup.sh"
    xmonad $ myConfig
