return {
  "github/copilot.vim",
  lazy = false, -- load on startup
  event = "InsertEnter",
  config = function()
    -- Optional: disable default Tab mapping if you want to map manually
    vim.g.copilot_no_tab_map = false
  end,
}
