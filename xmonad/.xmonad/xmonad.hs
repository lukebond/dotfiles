import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myManageHook = composeAll
    [ className =? "Gimp"        --> doFloat
    ]

startup :: X ()
startup = do
    setWMName "LG3D"
    spawn "pidof gnome-screensaver || gnome-screensaver"
    spawn "pidof xautolock || xautolock -time 10 -locker \"gnome-screensaver-command -l & sudo pm-suspend\""

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/lbond/.xmobarrc"
    xmonad $ defaultConfig
        {
            normalBorderColor = "#333333",
            focusedBorderColor = "#ff0000",
            borderWidth = 1,
            manageHook = manageDocks <+> myManageHook
                                     <+> manageHook defaultConfig,
            layoutHook = avoidStruts  $  layoutHook defaultConfig,
            logHook = dynamicLogWithPP xmobarPP
                {
                    ppOutput = hPutStrLn xmproc,
                    ppTitle = xmobarColor "green" "" . shorten 50
                },
            modMask = mod4Mask,
            startupHook = startup
        } `additionalKeys`
        [
           ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l"),
           ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s"),
           ((0, xK_Print), spawn "scrot")
        ]
