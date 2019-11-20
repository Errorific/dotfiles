import XMonad
import XMonad.Config.Desktop
import XMonad.Actions.SpawnOn

main = xmonad def
  { terminal = "urxvt"
  , modMask = mod4Mask
  , startupHook = myStartupHook
  }

myStartupHook = spawnHere "~/.fehbg"
