----------------------------------
-- Md.hs
-- Markdown related functions
--
-- @since 0.1.0.0
-- @author Thoq
----------------------------------
{-# LANGUAGE OverloadedStrings #-}

module Md (convertMdToHtml) where

import Data.Text (Text)
import qualified Data.Text as T

----------------------------------

escapeHtml :: Text -> Text
escapeHtml =
  T.replace (T.pack "<") (T.pack "&lt;")
    . T.replace (T.pack ">") (T.pack "&gt;")
    . T.replace (T.pack "'") (T.pack "&#39;")

----------------------------------

convertMdToHtml :: Text -> Text
convertMdToHtml = T.unlines . convertLines False . T.lines
  where
    convertLines :: Bool -> [Text] -> [Text]
    convertLines _ [] = []
    convertLines inCodeBlock (line : rest)
      | (T.pack "```") `T.isPrefixOf` line =
          if inCodeBlock
            then (T.pack "</code></pre>") : convertLines False rest
            else (T.pack "<pre><code>") : convertLines True rest
      | inCodeBlock = escapeHtml line : convertLines True rest
      | (T.pack "::: ") `T.isPrefixOf` line =
          let title = T.drop 4 line
              (dropdownLines, remainingLines) = span isDropdownContent rest
              indentedContent = map unindent dropdownLines
              dropdownHtml = convertMdToHtml (T.unlines indentedContent)
           in ((T.pack "<details><summary>") <> title <> (T.pack "</summary><div class=\"details-content\">"))
                : T.lines dropdownHtml
                ++ [T.pack "</div></details>"]
                ++ convertLines False remainingLines
      | (T.pack "> ") `T.isPrefixOf` line =
          let (quoteLines, remainingLines) = span ((T.pack "> ") `T.isPrefixOf`) (line : rest)
              unquotedLines = map (T.drop 2) quoteLines
              quoteHtml = convertMdToHtml (T.unlines unquotedLines)
           in (T.pack "<blockquote>") : T.lines quoteHtml ++ [T.pack "</blockquote>"] ++ convertLines False remainingLines
      | (T.pack "###### ") `T.isPrefixOf` line = ((T.pack "<h6>") <> T.drop 7 line <> (T.pack "</h6>")) : convertLines False rest
      | (T.pack "##### ") `T.isPrefixOf` line = ((T.pack "<h5>") <> T.drop 6 line <> (T.pack "</h5>")) : convertLines False rest
      | (T.pack "#### ") `T.isPrefixOf` line = ((T.pack "<h4>") <> T.drop 5 line <> (T.pack "</h4>")) : convertLines False rest
      | (T.pack "### ") `T.isPrefixOf` line = ((T.pack "<h3>") <> T.drop 4 line <> (T.pack "</h3>")) : convertLines False rest
      | (T.pack "## ") `T.isPrefixOf` line = ((T.pack "<h2>") <> T.drop 3 line <> (T.pack "</h2>")) : convertLines False rest
      | (T.pack "# ") `T.isPrefixOf` line = ((T.pack "<h1>") <> T.drop 2 line <> (T.pack "</h1>")) : convertLines False rest
      | otherwise = ((T.pack "<p>") <> parseInline line <> (T.pack "</p>")) : convertLines False rest
      where
        isDropdownContent s = T.null s || (T.pack "  ") `T.isPrefixOf` s
        unindent s
          | (T.pack "  ") `T.isPrefixOf` s = T.drop 2 s
          | otherwise = s

----------------------------------

parseInline :: Text -> Text
parseInline text
  | T.null text = T.pack ""
  | (T.pack "**") `T.isPrefixOf` text =
      let (boldText, rest) = spanUntil (T.pack "**") (T.drop 2 text)
       in (T.pack "<strong>") <> parseInline boldText <> (T.pack "</strong>") <> parseInline (T.drop 2 rest)
  | (T.pack "*") `T.isPrefixOf` text =
      let (italicText, rest) = spanUntil (T.pack "*") (T.drop 1 text)
       in (T.pack "<em>") <> parseInline italicText <> (T.pack "</em>") <> parseInline (T.drop 1 rest)
  | (T.pack "`") `T.isPrefixOf` text =
      let (inlineCode, rest) = spanUntil (T.pack "`") (T.drop 1 text)
       in (T.pack "<code>") <> escapeHtml inlineCode <> (T.pack "</code>") <> parseInline (T.drop 1 rest)
  | otherwise = T.cons (T.head text) (parseInline (T.tail text))

----------------------------------

spanUntil :: Text -> Text -> (Text, Text)
spanUntil delim str = T.breakOn delim str

----------------------------------
