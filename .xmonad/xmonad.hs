import XMonad
import XMonad.Config.Desktop
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import System.Taffybar.Support.PagerHints (pagerHints)

import           XMonad.Hooks.ManageHelpers       (doFullFloat, isFullscreen)
import qualified XMonad.StackSet as W
import           XMonad.Layout.NoBorders          (smartBorders)
import           XMonad.Layout.ThreeColumns       (ThreeCol (ThreeCol, ThreeColMid))
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.DynamicLog (def, dynamicLogWithPP, ppSort)
import qualified Data.Map        as M
import Graphics.X11.ExtraTypes.XF86

myConfig = def
  { terminal = "urxvt"
  , modMask = mod4Mask
  , keys = myKeys
  , layoutHook = myLayoutHook
  , manageHook = manageDocks <+> manageHook def <+> namedScratchpadManageHook scratchpads <+> myManageHook
  -- , logHook = dynamicLogWithPP def {
  --              ppSort = fmap (namedScratchpadFilterOutWorkspace.) $ ppSort def
  --          }
  , logHook = dynamicLogWithPP . namedScratchpadFilterOutWorkspacePP $ def
  }

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "rofi -combi-mode window,drun -show combi -modi combi"

scratchpads =
   [ NS "visor-term" "urxvt -name visor-term" (resource =? "visor-term")
      (customFloating $ W.RationalRect (0/1) (0/1) (1/1) (1/2))
   ]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_p),
     spawn myLauncher) 
  , ((modMask, xK_space),
     spawn myLauncher) 

  , ((modMask, xK_apostrophe), namedScratchpadAction scratchpads "visor-term")
  
  -- Mute volume.
  , ((0, xF86XK_AudioMute),
     spawn "amixer -q set Master toggle")

  -- Decrease volume.
  , ((0, xF86XK_AudioLowerVolume),
     spawn "amixer -q set Master 5%-")

  -- Increase volume.
  , ((0, xF86XK_AudioRaiseVolume),
     spawn "amixer -q set Master 5%+")
 
  -- Increase & Decrease brightness
  , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5%-")
  , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +5%")

--------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  -- meta-space stolen for launcher
  -- , ((modMask, xK_space),
  --   sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     spawn "loginctl kill-user $USER")

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myManageHook = composeAll
  [ isFullscreen --> doFullFloat
  ]

-- avoidStruts tells windows to avoid the "strut" where docks live
myLayoutHook = smartBorders $ avoidStruts $ layoutHook def ||| ThreeColMid 1 (3/100) (1/2)

main = xmonad . docks . pagerHints . ewmh $ myConfig

