{- xmonad.hs
 - Original Author: Øyvind 'Mr.Elendig' Heggstad <mrelendig AT har-ikkje DOT net>
 - Modifier: Gigamo <gigamo@gmail.com>
 - Version: 0.0.8
 -}
 
-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import IO (Handle, hPutStrLn) 
 
-- utils
import XMonad.Util.Run (spawnPipe)
 
-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
 
-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
 
-------------------------------------------------------------------------------
-- Main --
main = do
       h <- spawnPipe "xmobar"
       xmonad $ defaultConfig 
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , logHook = logHook' h 
              , layoutHook = layoutHook'
              , manageHook = manageHook'
              }
 
-------------------------------------------------------------------------------
-- Hooks --
manageHook' :: ManageHook
manageHook' = (doF W.swapDown) <+> manageHook defaultConfig <+> manageDocks
 
logHook' :: Handle ->  X ()
logHook' h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }
 
layoutHook' = customLayout
 
-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP :: PP
customPP = defaultPP { ppCurrent = xmobarColor "#FFFFFF" "#0066FF" . wrap "<" ">"
                     , ppTitle =  shorten 80
                     , ppSep =  "<fc=#0066FF> | </fc>"
                     , ppHiddenNoWindows = xmobarColor "#777777" ""
                     , ppUrgent = xmobarColor "#AFAFAF" "#333333" . wrap "<" ">"
                     }
 
-- borders
borderWidth' :: Dimension
borderWidth' = 1
 
normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#2A2A2A"
focusedBorderColor' = "#0066FF"
 
-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
 
-- layouts
customLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled)  ||| noBorders Full
  where
    tiled = ResizableTall 1 (2/100) (1/2) []
 
-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "urxvt"
 
-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod4Mask
 
-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,               xK_x     ), spawn $ XMonad.terminal conf)
    , ((modMask,               xK_r     ), spawn "dmenu_run -fn \"-*-terminus-medium-r-normal-*-12-*-*-*-*-*-*-*\" -nb \"#131313\" -nf \"#888888\" -sb \"#2A2A2A\" -sf \"#3579A8\"")
--    , ((modMask,               xK_r     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modMask,               xK_f     ), spawn "firefox") 
    , ((modMask,               xK_t     ), spawn "thunar") 
    , ((modMask,               xK_c     ), kill)
 
    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)
 
    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
 
    -- refresh
    , ((modMask,               xK_n     ), refresh)
 
    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)
 
    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- increase or decrease number of windows in the master area
    , ((modMask .|. controlMask, xK_h     ), sendMessage (IncMasterN 1))
    , ((modMask .|. controlMask, xK_l     ), sendMessage (IncMasterN (-1)))
 
    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)
 
    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
 
-------------------------------------------------------------------------------
