module Print where

import Ascii

--------------------------------------------------

infoIcon :: String
infoIcon = "\xf05a  "

errorIcon :: String
errorIcon = "\xf530  "

checkIcon :: String
checkIcon = "\xf4a4  "

--------------------------------------------------

print_info :: String -> IO ()
print_info message = do
  putStrLn $ (colorCode "magenta") ++ infoIcon ++ message ++ reset

print_error :: String -> IO ()
print_error message = do
  putStrLn $ (colorCode "red") ++ errorIcon ++ message ++ reset

print_ok :: String -> IO ()
print_ok message = do
  putStrLn $ (colorCode "green") ++ checkIcon ++ message ++ reset

--------------------------------------------------
