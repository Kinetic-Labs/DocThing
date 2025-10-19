module Main where

import Ascii
import Lib
import System.Environment

dispatchAction :: [String] -> IO ()
dispatchAction [input] = do
  let outputFile = getOutputFile input

  processMd input outputFile
dispatchAction [input, output] = do
  processMd input output
dispatchAction _ = do
  let errorIcon = "\xf530  "

  putStrLn $ (colorCode "red") ++ errorIcon ++ "Please specify the input file (and optionally output) with docthing <input> [output]"

main :: IO ()
main = do
  let checkIcon = "\xf4a4  "
  putStrLn asciiArt

  putStrLn $ (colorCode "green") ++ checkIcon ++ "Starting DocThing..."

  args <- getArgs

  dispatchAction args

  putStrLn $ (colorCode "green") ++ checkIcon ++ "Done!"
