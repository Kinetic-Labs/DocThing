--------------------------------------------------
-- Web.hs
-- Web related functions
--
-- @since 0.1.1.0
-- @author Thoq
--------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Web (styles, footer) where

import Data.ByteString (ByteString)
import Data.FileEmbed (embedFile)
import Data.Text (Text)
import Data.Text.Encoding (decodeUtf8)

--------------------------------------------------

getStyles :: ByteString
getStyles = $(embedFile "assets/styles.css")

styles :: Text
styles = "<style>" <> (decodeUtf8 getStyles) <> "</style>"

getFooter :: ByteString
getFooter = $(embedFile "assets/footer.html")

footer :: Text
footer = decodeUtf8 getFooter

--------------------------------------------------
