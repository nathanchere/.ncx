import XMonad
import XMonad.Config.Mate
import XMonad.Layout.Spacing

myTerminal = "terminator"
myModMask = mod4Mask

myBorderWidth = 3
myFocusedBorderColor = "#BBFF00"
myNormalBorderColor = "#778877"

myLayoutHook = spacingWithEdge 4
  $ layoutHook mateConfig

myWorkspaces = ["1:\xf121","2:\xf02d","3:code", "4:misc"] ++ map show [5..8]

myConfig = mateConfig
  { terminal = myTerminal
  , modMask = myModMask

  , borderWidth = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myNormalBorderColor
  
  , layoutHook = myLayoutHook
  , workspaces = myWorkspaces
  }

main = do
    spawn "bash ~/.xmonad/startup.sh"
    xmonad $ myConfig
