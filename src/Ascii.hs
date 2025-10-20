module Ascii (colorCode, colors, asciiArt, reset) where

import Data.Maybe

--------------------------------------------------

colors :: [(String, String)]
colors =
  [ ("reset", "\ESC[0m"),
    ("black", "\ESC[30m"),
    ("red", "\ESC[31m"),
    ("green", "\ESC[32m"),
    ("yellow", "\ESC[33m"),
    ("blue", "\ESC[34m"),
    ("magenta", "\ESC[35m"),
    ("cyan", "\ESC[36m"),
    ("white", "\ESC[37m"),
    ("brightBlack", "\ESC[90m"),
    ("brightRed", "\ESC[91m"),
    ("brightGreen", "\ESC[92m"),
    ("brightYellow", "\ESC[93m"),
    ("brightBlue", "\ESC[94m"),
    ("brightMagenta", "\ESC[95m"),
    ("brightCyan", "\ESC[96m"),
    ("brightWhite", "\ESC[97m")
  ]

colorCode :: String -> String
colorCode name = Data.Maybe.fromMaybe "" (lookup name colors)

reset :: String
reset = colorCode $ "reset"

asciiArt :: String
asciiArt =
  colorCode "brightMagenta"
    ++ "          DocThing          \n\
       \                     ,----, \n\
       \                   ,/   .`| \n\
       \    ,---,        ,`   .'  : \n\
       \  .'  .' `\\    ;    ;     / \n\
       \,---.'     \\ .'___,/    ,'  \n\
       \|   |  .`\\  ||    :     |   \n\
       \:   : |  '  |;    |.';  ;   \n\
       \|   ' '  ;  :`----'  |  |   \n\
       \'   | ;  .  |    '   :  ;   \n\
       \|   | :  |  '    |   |  '   \n\
       \'   : | /  ;     '   :  |   \n\
       \|   | '` ,/      ;   |.'    \n\
       \;   :  .'        '---'      \n\
       \|   ,.'                     \n\
       \'---'                       \n\
       \       By Kinetic Labs      \n"
    ++ colorCode "reset"

--------------------------------------------------
