module Md (convertMdToHtml) where

import Data.List (isPrefixOf)

convertMdToHtml :: String -> String
convertMdToHtml = unlines . map convertLine . lines
  where
    convertLine :: String -> String
    convertLine line
      | "### " `isPrefixOf` line = "<h3>" ++ drop 4 line ++ "</h3>"
      | "## " `isPrefixOf` line = "<h2>" ++ drop 3 line ++ "</h2>"
      | "# " `isPrefixOf` line = "<h1>" ++ drop 2 line ++ "</h1>"
      | otherwise = "<p>" ++ parseInline line ++ "</p>"

    parseInline :: String -> String
    parseInline [] = []
    parseInline ('*' : '*' : xs) =
      let (boldText, rest) = spanUntil "**" xs
       in "<strong>" ++ parseInline boldText ++ "</strong>" ++ parseInline (drop 2 rest)
    parseInline ('*' : xs) =
      let (italicText, rest) = spanUntil "*" xs
       in "<em>" ++ parseInline italicText ++ "</em>" ++ parseInline (drop 1 rest)
    parseInline (x : xs) = x : parseInline xs

    spanUntil :: String -> String -> (String, String)
    spanUntil delim str = go str
      where
        go [] = ("", "")
        go s@(x : xs)
          | delim `isPrefixOf` s = ("", s)
          | otherwise =
              let (first, rest) = go xs
               in (x : first, rest)
