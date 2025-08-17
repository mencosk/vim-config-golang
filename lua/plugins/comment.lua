return {
  -- commenting out lines
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end,
  },
}
