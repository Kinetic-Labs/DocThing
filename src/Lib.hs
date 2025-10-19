module Lib (getOutputFile, processMd) where

import Ascii
import Md

getOutputFile :: [Char] -> [Char]
getOutputFile fileName = fileName ++ ".html"

processMd :: [Char] -> [Char] -> IO ()
processMd inputFile outputFile = do
  let infoIcon = "\xf05a  "

  putStrLn $ (colorCode "magenta") ++ infoIcon ++ "Processing Markdown"

  putStrLn $ (colorCode "magenta") ++ infoIcon ++ "Reading file"
  contents <- readFile inputFile

  putStrLn $ (colorCode "magenta") ++ infoIcon ++ "Translating Markdown to HTML"
  let html = convertMdToHtml contents

  putStrLn $ (colorCode "magenta") ++ infoIcon ++ "Writing result"
  writeFile outputFile html
