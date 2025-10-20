module Main where

import Print
import Lib
import Ascii
import System.Environment

--------------------------------------------------

dispatchAction :: [String] -> IO ()
dispatchAction [input] = do
  let outputFile = getOutputFile input

  processMd input outputFile
dispatchAction [input, output] = do
  processMd input output
dispatchAction _ = do
  print_error "Please specify the input file (and optionally output) with docthing <input> [output]"

--------------------------------------------------

main :: IO ()
main = do
  putStrLn asciiArt

  print_ok "Starting DocThing..."

  args <- getArgs

  dispatchAction args

  print_ok "Done!"

--------------------------------------------------
