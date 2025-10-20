# DocThing

Generate documentation from HTML or code comments

::: Roadmap
  ## Roadmap

  Todo: implement comment parsing

## Usage
Simply specify the input
`docthing <input.md>`

and optionally specify the output file:
`docthing <input.md> <output.md>`

## Here are some examples

::: Example Markdown
  ### Headings
  Headings are the standard `#` symbol
  ```md
  # H1
  ## H2
  ### H3
  ```
  this goes on up to h6

  ### Typing
  Typing is just like Markdown, using asteriks to denote a certain effect
  ```md
  *Italic*
  **Bold**
  ***Italic and Bold***
  ```

  ### Codeblocks
  Uses backticks like Markdown
  `inline code`

  usual three backticks (`Shift + ~`)

  ### Blockquote
  Uses the chevron
  ```md
  > Blockquote
  ```

  ### Dropdowns
  Now dropdowns are handled differently than Markdown.
  Markdown does **not** handle it very well,
  DocThing uses three colons (`Shift + ;`, `:`) and the format is:
  ```
  ::: title
    (indented)
  ```

  so it can be written as:
  ```md
  ::: im a dropdown
    ### Hello!
  ```

  More examples will be comming soon
