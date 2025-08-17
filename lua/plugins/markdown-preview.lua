return {
  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    dependencies = {
      "zhaozg/vim-diagram",
      "aklt/plantuml-syntax",
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    config = function ()
     -- vim.gmkdp_browser = "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_theme = "dark"   -- set default theme (dark or light)
    end,
  },
}
