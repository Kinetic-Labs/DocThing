module Md (convertMdToHtml) where

import Data.List (isPrefixOf)

--------------------------------------------------

convertMdToHtml :: String -> String
convertMdToHtml = unlines . convertLines False . lines
  where
    convertLines :: Bool -> [String] -> [String]
    convertLines _ [] = []
    convertLines inCodeBlock (line : rest)
      | "```" `isPrefixOf` line =
          if inCodeBlock
            then "</code></pre>" : convertLines False rest
            else "<pre><code>" : convertLines True rest
      | inCodeBlock = line : convertLines True rest
      | "::: " `isPrefixOf` line =
          let title = drop 4 line
              (dropdownLines, remainingLines) = span isDropdownContent rest
              indentedContent = map unindent dropdownLines
              dropdownHtml = convertMdToHtml (unlines indentedContent)
           in ("<details><summary>" ++ title ++ "</summary><div class=\"details-content\">")
              : lines dropdownHtml
              ++ ["</div></details>"]
              ++ convertLines False remainingLines
      | "###### " `isPrefixOf` line = ("<h6>" ++ drop 7 line ++ "</h6>") : convertLines False rest
      | "##### " `isPrefixOf` line = ("<h5>" ++ drop 6 line ++ "</h5>") : convertLines False rest
      | "#### " `isPrefixOf` line = ("<h4>" ++ drop 5 line ++ "</h4>") : convertLines False rest
      | "### " `isPrefixOf` line = ("<h3>" ++ drop 4 line ++ "</h3>") : convertLines False rest
      | "## " `isPrefixOf` line = ("<h2>" ++ drop 3 line ++ "</h2>") : convertLines False rest
      | "# " `isPrefixOf` line = ("<h1>" ++ drop 2 line ++ "</h1>") : convertLines False rest
      | otherwise = ("<p>" ++ parseInline line ++ "</p>") : convertLines False rest
      where
        isDropdownContent s = null s || "  " `isPrefixOf` s
        unindent s
          | "  " `isPrefixOf` s = drop 2 s
          | otherwise = s

--------------------------------------------------

parseInline :: String -> String
parseInline [] = []
parseInline ('*' : '*' : xs) =
  let (boldText, rest) = spanUntil "**" xs
   in "<strong>" ++ parseInline boldText ++ "</strong>" ++ parseInline (drop 2 rest)
parseInline ('*' : xs) =
  let (italicText, rest) = spanUntil "*" xs
   in "<em>" ++ parseInline italicText ++ "</em>" ++ parseInline (drop 1 rest)
parseInline ('`' : xs) =
  let (inlineCode, rest) = spanUntil "`" xs
   in "<code>" ++ parseInline inlineCode ++ "</code>" ++ parseInline (drop 1 rest)
parseInline (x : xs) = x : parseInline xs

--------------------------------------------------

spanUntil :: String -> String -> (String, String)
spanUntil delim str = go str
  where
    go [] = ("", "")
    go s@(x : xs)
      | delim `isPrefixOf` s = ("", s)
      | otherwise =
          let (first, rest) = go xs
           in (x : first, rest)

--------------------------------------------------
