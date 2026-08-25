return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup {}

      local parsers = {
        "go", "gomod", "proto",
        "lua", "vimdoc", "vim",
        "bash", "fish",
        "json", "markdown", "markdown_inline",
        "mermaid",
      }
      require("nvim-treesitter").install(parsers)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
      local ts_move = require("nvim-treesitter-textobjects.move")

      -- select
      vim.keymap.set({ "x", "o" }, "aa", function() ts_select("@parameter.outer", "textobjects") end, { desc = "parameter outer" })
      vim.keymap.set({ "x", "o" }, "ia", function() ts_select("@parameter.inner", "textobjects") end, { desc = "parameter inner" })
      vim.keymap.set({ "x", "o" }, "af", function() ts_select("@function.outer", "textobjects") end, { desc = "function outer" })
      vim.keymap.set({ "x", "o" }, "if", function() ts_select("@function.inner", "textobjects") end, { desc = "function inner" })
      vim.keymap.set({ "x", "o" }, "ac", function() ts_select("@class.outer", "textobjects") end, { desc = "class outer" })
      vim.keymap.set({ "x", "o" }, "ic", function() ts_select("@class.inner", "textobjects") end, { desc = "class inner" })
      vim.keymap.set({ "x", "o" }, "iB", function() ts_select("@block.inner", "textobjects") end, { desc = "block inner" })
      vim.keymap.set({ "x", "o" }, "aB", function() ts_select("@block.outer", "textobjects") end, { desc = "block outer" })

      -- move
      vim.keymap.set({ "n", "x", "o" }, "]]", function() ts_move.goto_next_start("@function.outer", "textobjects") end, { desc = "next function start" })
      vim.keymap.set({ "n", "x", "o" }, "][", function() ts_move.goto_next_end("@function.outer", "textobjects") end, { desc = "next function end" })
      vim.keymap.set({ "n", "x", "o" }, "[[", function() ts_move.goto_previous_start("@function.outer", "textobjects") end, { desc = "prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "[]", function() ts_move.goto_previous_end("@function.outer", "textobjects") end, { desc = "prev function end" })

      -- swap
      local ts_swap = require("nvim-treesitter-textobjects.swap")
      vim.keymap.set("n", "<leader>sn", function() ts_swap.swap_next("@parameter.inner") end, { desc = "swap next param" })
      vim.keymap.set("n", "<leader>sp", function() ts_swap.swap_previous("@parameter.inner") end, { desc = "swap prev param" })
    end,
  },
}
