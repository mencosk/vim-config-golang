return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local map = vim.keymap.set
        map("n", "]c", function() gitsigns.nav_hunk("next") end, { desc = "Next hunk", buffer = bufnr })
        map("n", "[c", function() gitsigns.nav_hunk("prev") end, { desc = "Prev hunk", buffer = bufnr })
      end,
    },
  },
}
