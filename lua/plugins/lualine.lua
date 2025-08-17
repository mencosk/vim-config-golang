return {
    -- statusline
    -- A blazing fast an easy to configure neovim statusline written in pure lua. 
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require("lualine").setup({
        options = { theme = 'gruvbox' },
        -- options = { theme = require("rusty").lualine },
        -- options = { theme = "catppuccin" },
        -- options = { theme = "tokyonight"},
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          }
        }
      })
    end
}
