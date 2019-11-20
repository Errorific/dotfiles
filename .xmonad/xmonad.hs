import XMonad
import XMonad.Config.Desktop
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import System.Taffybar.Support.PagerHints (pagerHints)

myConfig = def
  { terminal = "urxvt"
  , modMask = mod4Mask
  }

main = xmonad . docks . pagerHints . ewmh $ myConfig


