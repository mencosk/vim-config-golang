return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
      require("gruvbox").setup({
       -- inverse = true, -- invert background for search, diffs, statuslines and errors
	      contrast = "hard", -- can be "hard", "soft" or empty string
        --terminal_colors = true,
        --transparent_mode = true,
        italic = {
          comments = false,
          strings = false,
          operators = false,
          emphasis = false,
          folds = false,
        },
        overrides = {
          -- Color scheme with adjustments for Golang
          Function = { fg = "#FAC706" },     -- Yellow for function declarations (func myFunction())
          Keyword = { fg = "#FFDF7F" },      -- Bright wheat for keywords (func, type, var, return)
          Type = { fg = "#FEC990" },         -- Light tan for types (string, int, struct)
          Delimiter = { fg = "#8F8F8F" },    -- Mid gray for brackets, braces, parentheses ({, }, (, ))
          Operator = { fg = "#9F9D6D" },     -- Olive for operators (+, -, *, /, :=)
          String = { fg = "#CC9393" },       -- Soft rose for string literals ("hello")
          Number = { fg = "#8CD0D3" },       -- Light blue for numbers (42, 3.14)
          Boolean = { fg = "#DCA3A3" },      -- Light coral for booleans (true, false)
          Comment = { fg = "#7F9F7F" },      -- Sage green for comments (// and /* */)
          Constant = { fg = "#BFEBBF" },     -- Light green for constants (const MaxSize = 100)
          Variable = { fg = "#DCDCCC" },     -- Light gray for variable names (myVar)
          Field = { fg = "#DFAF8F" },        -- Light salmon for struct fields (type Person { Name string })
          Method = { fg = "#93E0E3" },       -- Cyan for method declarations (func (s *Server) Start())
          Parameter = { fg = "#DFE4CF" },    -- Off-white for function parameters (func(name string))
          Special = { fg = "#DFAF8F" },      -- Light salmon for special characters
          Statement = { fg = "#DFAF8F" },    -- Light salmon for statements (if, else, switch)
          PreProc = { fg = "#DFAF8F" },      -- Light salmon for preprocessor directives
          Identifier = { fg = "#DCDCCC" },   -- Light gray for general identifiers
          Conditional = { fg = "#DFAF8F" },  -- Light salmon for if/else conditions
          Repeat = { fg = "#87AFAF" },       -- Muted blue-gray for loops (for, range)
          -- TreeSitter specific overrides
          ["@constant"] = { fg = "#D4EFDF" },           -- Mint green for constants (http.StatusOK) D4EFDF
          ["@constant.builtin"] = { fg = "#D4EFDF" },   -- Same mint green for builtin constants (nil, iota)
          ["@variable.member"] = { fg = "#D4EFDF" },    -- Same mint green for member constants (errors.New)
          ["@string.special"] = { fg = "#DAF7A6" },     -- Light olive for string formatting verbs (%v, %s, %d)
          ["@string.escape"] = { fg = "#DAF7A6" },      -- Light olive for escape sequences (\n, \t)
          ["@method.call"] = { fg = "#D6EAF8" },        -- Turquoise for first method calls (client.Do())
          ["@method.call.third"] = { fg = "#FA8072" },  -- Salmon for third chained calls (w.Header().Set())
          ["@function.call"] = { fg = "#D6EAF8" },      -- Turquoise for function calls (fmt.Println())
          SpecialChar = { fg = "#DAF7A6" },             -- Light olive for format specifiers (%v, %s, %d)
        },
      })
      vim.cmd("colorscheme gruvbox")
  end,
}

