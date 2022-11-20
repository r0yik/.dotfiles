------------------------------------------------------------------------
-- Import lib

import XMonad
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Actions
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing

-- Layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed

-- Layouts modifiers
import XMonad.Layout.WindowArranger
import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName
import XMonad.Layout.Renamed

-- Util
import XMonad.Util.Run
import XMonad.Util.Cursor
import qualified XMonad.Util.Hacks as Hacks

------------------------------------------------------------------------
-- General settings

myTerminal = "alacritty"
myModMask = mod4Mask

myBorderWidth = 1
myNormalBorderColor     = "#262626"
myFocusedBorderColor    = "#ededed"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myWorkspaces = ["i","ii","iii","iv", "v", "vi", "vii", "viii", "ix"]

toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
    )

------------------------------------------------------------------------
-- Key bindings
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,                   xK_Return), spawn $ XMonad.terminal conf)

    -- close focused window
    , ((modm,                   xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm .|. controlMask,   xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask,     xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Move focus to the next window
    , ((modm,                   xK_l     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,                   xK_g     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,                   xK_m     ), windows W.focusMaster  )

    -- Move to next workspace
    , ((modm .|. controlMask,   xK_l     ), nextWS)

    -- Move to previous workspace
    , ((modm .|. controlMask,   xK_g     ), prevWS)

    -- find next empty workspace
    , ((modm,                   xK_e     ), moveTo Next emptyWS)

    -- Move window to next empty workspace
    , ((modm .|. shiftMask,     xK_e     ), shiftTo Next emptyWS)

    -- Swap the focused window and the master window
    , ((modm .|. controlMask,   xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask,     xK_l     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask,     xK_g     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm .|. shiftMask,     xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm .|. shiftMask,     xK_s     ), sendMessage Expand)

    -- Toggle floating
    , ((modm,                   xK_space ), withFocused toggleFloat)

    -- Push window back into tiling
    , ((modm,                   xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm .|. shiftMask,     xK_i     ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm .|. shiftMask,     xK_d     ), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    , ((modm .|. shiftMask,     xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask,     xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask,     xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2
    -- mod-shift-{w,e,r}, Move client to screen 1, 2

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_v, xK_z] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

------------------------------------------------------------------------
-- Layouts:

myLayout = avoidStruts $ mouseResize $ windowArrange (tiled ||| Mirror tiled ||| Grid ||| renamed [Replace "Tabbed"] simpleTabbed ||| noBorders Full |||  renamed [Replace "Float"] simplestFloat)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 1/100

------------------------------------------------------------------------
-- Window rules

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- myEventHook = windowedFullscreenFixEventHook <> swallowEventHook (className =? "alacritty" <||> className =? "XTerm") (return True) <> trayerPaddingXmobarEventHook

------------------------------------------------------------------------
-- Startup hook

myStartupHook = do
                setDefaultCursor xC_left_ptr
                spawn "killall xmobar"
                spawn "killall trayer"
                spawn ("sleep 4 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent false --alpha 0 --height 22")

------------------------------------------------------------------------
-- Run xmonad
--
main = do 
       h <- spawnPipe "sleep 4 && xmobar $HOME/.config/xmobar/xmobar.hs"
       xmonad $ docks def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = showWName myLayout,
        manageHook         = myManageHook,
        handleEventHook    = Hacks.windowedFullscreenFixEventHook <> swallowEventHook (className =? "alacritty" <||> className =? "XTerm") (return True) <> Hacks.trayerPaddingXmobarEventHook <> Hacks.trayerAboveXmobarEventHook,
        startupHook        = myStartupHook,
        logHook            = dynamicLogWithPP $ def { ppOutput = hPutStrLn h 
                           , ppCurrent = xmobarColor "#ffffff" "#0f0f0f" 
                           , ppVisible = xmobarColor "#ffffff" "#0f0f0f"
                           , ppHidden = xmobarColor "#aaaaaa" "#0f0f0f"
                           , ppHiddenNoWindows = xmobarColor "#444444" "#0f0f0f"
                           , ppTitle = xmobarColor "#dddddd" "#0f0f0f"
                           , ppWsSep = " "
                           , ppSep = "  :  "
                           , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                           }
        }
