{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------
-- Main.hs
-- Main entrypoint for DocThing
--
-- @author Thoq
-- @since 0.1.0.0
--------------------------------------------------

module Main where

import Ascii
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Lib
import Print
import System.Environment

--------------------------------------------------

dispatchAction :: [Text] -> IO ()
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
  T.putStrLn asciiArt

  print_info "Starting DocThing..."

  args <- getArgs
  let textArgs = map T.pack args

  print_ok "Started DocThing!"

  dispatchAction textArgs

  print_ok "Done!"

--------------------------------------------------
