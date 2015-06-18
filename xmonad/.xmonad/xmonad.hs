import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/luke/.xmobarrc"
    xmonad $ defaultConfig
        {
            normalBorderColor = "#333333",
            focusedBorderColor = "#ff0000",
            borderWidth = 1,
            terminal = "gnome-terminal",
            manageHook = manageDocks <+> manageHook defaultConfig,
            layoutHook = avoidStruts  $  layoutHook defaultConfig,
            logHook = dynamicLogWithPP xmobarPP
                {
                    ppOutput = hPutStrLn xmproc,
                    ppTitle = xmobarColor "green" "" . shorten 50
                },
            modMask = mod4Mask
        }
