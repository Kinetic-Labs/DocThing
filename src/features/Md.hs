{-# LANGUAGE OverloadedStrings #-}

--------------------------------------------------
-- Md.hs
-- Markdown related functions
--
-- @since 0.1.0.0
-- @author Thoq
--------------------------------------------------

module Md (convertMdToHtml) where

import Data.Text (Text)
import qualified Data.Text as T

--------------------------------------------------

convertMdToHtml :: Text -> Text
convertMdToHtml = T.unlines . convertLines False . T.lines
  where
    convertLines :: Bool -> [Text] -> [Text]
    convertLines _ [] = []
    convertLines inCodeBlock (line : rest)
      | "```" `T.isPrefixOf` line =
          if inCodeBlock
            then "</code></pre>" : convertLines False rest
            else "<pre><code>" : convertLines True rest
      | inCodeBlock = line : convertLines True rest
      | "::: " `T.isPrefixOf` line =
          let title = T.drop 4 line
              (dropdownLines, remainingLines) = span isDropdownContent rest
              indentedContent = map unindent dropdownLines
              dropdownHtml = convertMdToHtml (T.unlines indentedContent)
           in ("<details><summary>" <> title <> "</summary><div class=\"details-content\">")
                : T.lines dropdownHtml
                ++ ["</div></details>"]
                ++ convertLines False remainingLines
      | "###### " `T.isPrefixOf` line = ("<h6>" <> T.drop 7 line <> "</h6>") : convertLines False rest
      | "##### " `T.isPrefixOf` line = ("<h5>" <> T.drop 6 line <> "</h5>") : convertLines False rest
      | "#### " `T.isPrefixOf` line = ("<h4>" <> T.drop 5 line <> "</h4>") : convertLines False rest
      | "### " `T.isPrefixOf` line = ("<h3>" <> T.drop 4 line <> "</h3>") : convertLines False rest
      | "## " `T.isPrefixOf` line = ("<h2>" <> T.drop 3 line <> "</h2>") : convertLines False rest
      | "# " `T.isPrefixOf` line = ("<h1>" <> T.drop 2 line <> "</h1>") : convertLines False rest
      | otherwise = ("<p>" <> parseInline line <> "</p>") : convertLines False rest
      where
        isDropdownContent s = T.null s || "  " `T.isPrefixOf` s
        unindent s
          | "  " `T.isPrefixOf` s = T.drop 2 s
          | otherwise = s

--------------------------------------------------

parseInline :: Text -> Text
parseInline text
  | T.null text = ""
  | "**" `T.isPrefixOf` text =
      let (boldText, rest) = spanUntil "**" (T.drop 2 text)
       in "<strong>" <> parseInline boldText <> "</strong>" <> parseInline (T.drop 2 rest)
  | "*" `T.isPrefixOf` text =
      let (italicText, rest) = spanUntil "*" (T.drop 1 text)
       in "<em>" <> parseInline italicText <> "</em>" <> parseInline (T.drop 1 rest)
  | "`" `T.isPrefixOf` text =
      let (inlineCode, rest) = spanUntil "`" (T.drop 1 text)
       in "<code>" <> parseInline inlineCode <> "</code>" <> parseInline (T.drop 1 rest)
  | ">" `T.isPrefixOf` text =
      let (blockquote, rest) = spanUntil "\n" (T.drop 1 text)
       in "<blockquote>" <> parseInline blockquote <> "</blockquote>" <> parseInline (T.drop 1 rest)
  | otherwise = T.cons (T.head text) (parseInline (T.tail text))

--------------------------------------------------

spanUntil :: Text -> Text -> (Text, Text)
spanUntil delim str = T.breakOn delim str

--------------------------------------------------
