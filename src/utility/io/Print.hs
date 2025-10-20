{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------
-- Print.hs
-- Printing utility functions
--
-- @since 0.1.1.0
-- @author Thoq
--------------------------------------------------

module Print (print_ok, print_info, print_error) where

import Ascii
import Data.Text (Text)
import qualified Data.Text.IO as T

--------------------------------------------------

infoIcon :: Text
infoIcon = "\xf05a  "

errorIcon :: Text
errorIcon = "\xf530  "

checkIcon :: Text
checkIcon = "\xf4a4  "

--------------------------------------------------

print_info :: Text -> IO ()
print_info message = do
  T.putStrLn $ (colorCode "magenta") <> infoIcon <> message <> reset

print_error :: Text -> IO ()
print_error message = do
  T.putStrLn $ (colorCode "red") <> errorIcon <> message <> reset

print_ok :: Text -> IO ()
print_ok message = do
  T.putStrLn $ (colorCode "green") <> checkIcon <> message <> reset

--------------------------------------------------
