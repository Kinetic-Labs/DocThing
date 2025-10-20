{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------
-- Lib.hs
-- Main utility functions
--
-- @since 0.1.0.0
-- @author Thoq
--------------------------------------------------

module Lib (getOutputFile, processMd) where

import Data.Text (Text, unpack)
import qualified Data.Text.IO as TextIO
import Md
import Print
import Web

--------------------------------------------------

getOutputFile :: Text -> Text
getOutputFile fileName = fileName <> ".html"

--------------------------------------------------

processMd :: Text -> Text -> IO ()
processMd inputFile outputFile = do
  print_info "Processing Markdown"

  print_info "Reading file"
  contents <- TextIO.readFile (unpack inputFile)

  print_info "Translating Markdown to HTML"
  let rawHtml = convertMdToHtml contents

  print_info "Patching HTML"
  let html = styles <> rawHtml <> footer

  print_info "Writing result"
  TextIO.writeFile (unpack outputFile) html

--------------------------------------------------
