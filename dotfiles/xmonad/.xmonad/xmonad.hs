import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

myTerminal = "terminator"
myModMask = mod4Mask

myBorderWidth = 3
myFocusedBorderColor = "#BBFF00"
myNormalBorderColor = "#778877"

myLayoutHook = spacingWithEdge 4
  $ layoutHook desktopConfig

-- TODO: workspaces 9..16 for minimised windows
myWorkspaces = ["1:\xf121","2:\xf02d","3:code", "4:misc"] ++ map show [5..8]

myConfig = desktopConfig
  { terminal = myTerminal
  , modMask = myModMask

  , borderWidth = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myNormalBorderColor

  , layoutHook = myLayoutHook
  , workspaces = myWorkspaces
  }
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
