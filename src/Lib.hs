--------------------------------------------------
-- Lib.hs
-- Misc utility functions
--
-- @since 0.1.0.0
-- @author Thoq
--------------------------------------------------

module Lib (getOutputFile, processMd) where

import Md
import Print
import Web

--------------------------------------------------

getOutputFile :: [Char] -> [Char]
getOutputFile fileName = fileName ++ ".html"

--------------------------------------------------

processMd :: [Char] -> [Char] -> IO ()
processMd inputFile outputFile = do
  print_info "Processing Markdown"

  print_info "Reading file"
  contents <- readFile inputFile

  print_info "Translating Markdown to HTML"
  let rawHtml = convertMdToHtml contents

  print_info "Patching HTML"
  let html = styles ++ rawHtml ++ footer

  print_info "Writing result"
  writeFile outputFile html

--------------------------------------------------
