module Web (styles, footer) where

-- This is cursed, please excuse it :3

--------------------------------------------------

styles :: String
styles =
  "<style>\n\
  \  :root {\n\
  \    --accent-color: #bf8fff;\n\
  \  }\n\
  \\n\
  \  html {\n\
  \    padding: 30px;\n\
  \    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;\n\
  \    font-size: 16px;\n\
  \    line-height: 1.6;\n\
  \    background-color: #121212;\n\
  \    color: #DDDDDD;\n\
  \  }\n\
  \\n\
  \  body {\n\
  \    margin: 0;\n\
  \  }\n\
  \\n\
  \  hr {\n\
  \    border: none;\n\
  \    height: 1px;\n\
  \    background-color: #333333;\n\
  \    margin: 20px 0;\n\
  \  }\n\
  \\n\
  \  footer {\n\
  \    padding: 20px 30px;\n\
  \    margin-top: 40px;\n\
  \    font-size: 0.9em;\n\
  \    color: #AAAAAA;\n\
  \    text-align: center;\n\
  \  }\n\
  \\n\
  \  a {\n\
  \    color: var(--accent-color);\n\
  \    text-decoration: none;\n\
  \  }\n\
  \  a:hover {\n\
  \    text-decoration: underline;\n\
  \  }\n\
  \\n\
  \  p {\n\
  \    color: #CCCCCC;\n\
  \  }\n\
  \\n\
  \  h1, h2, h3, h4, h5, h6 {\n\
  \    color: #FFFFFF;\n\
  \    margin-top: 1.2em;\n\
  \    margin-bottom: 0.5em;\n\
  \  }\n\
  \\n\
  \  details {\n\
  \    border: 1px solid #333333;\n\
  \    border-radius: 6px;\n\
  \    margin-bottom: 1.2em;\n\
  \    background-color: #1a1a1a;\n\
  \  }\n\
  \\n\
  \  summary {\n\
  \    padding: 12px 15px;\n\
  \    cursor: pointer;\n\
  \    outline: none;\n\
  \    font-weight: 500;\n\
  \    background-color: #222222;\n\
  \  }\n\
  \\n\
  \  summary:hover {\n\
  \    background-color: #2a2a2a;\n\
  \  }\n\
  \\n\
  \  details[open] > summary {\n\
  \    border-bottom: 1px solid #333333;\n\
  \  }\n\
  \\n\
  \  .details-content {\n\
  \    padding: 15px;\n\
  \  }\n\
  \\n\
  \  pre code, .code-block {\n\
  \    background-color: #222222;\n\
  \    color: #AAAAAA;\n\
  \    padding: 15px;\n\
  \    border-radius: 6px;\n\
  \    display: block;\n\
  \    overflow-x: auto;\n\
  \    font-family: 'Courier New', monospace;\n\
  \    font-size: 0.95em;\n\
  \  }\n\
  \\n\
  \  code, .code-inline {\n\
  \    background-color: #333333;\n\
  \    color: var(--accent-color);\n\
  \    padding: 2px 6px;\n\
  \    border-radius: 4px;\n\
  \    font-family: 'Courier New', monospace;\n\
  \    font-size: 0.95em;\n\
  \  }\n\
  \</style>\n"

footer :: String
footer =
  "<footer>\n\
  \<hr>\n\
  \<p>\n\
  \Generated with\n\
  \<a href=\"https://github.com/Kinetic-Labs/DocThing\">DocThing</a>\n\
  \</p>\n\
  \<p>\n\
  \Made with <3 by\n\
  \<a href=\"https://github.com/Kinetic-Labs\">Kinetic Labs</a>\n\
  \</footer>"

--------------------------------------------------
