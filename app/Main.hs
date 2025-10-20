--------------------------------------------------
-- Main.hs
-- Main entrypoint for DocThing
--
-- @author Thoq
-- @since 0.1.0.0
--------------------------------------------------

module Main where

import Ascii
import Lib
import Print
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

  print_info "Starting DocThing..."

  args <- getArgs

  print_ok "Started DocThing!"

  dispatchAction args

  print_ok "Done!"

--------------------------------------------------
