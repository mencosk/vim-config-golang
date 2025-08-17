return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',
        enabled = true,
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { "nvim-telescope/telescope-file-browser.nvim", enabled = true },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },

    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'center',
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top"  -- search bar at the top
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          file_browser = {
            path = "%:p:h", -- open from within the folder of your current buffer
            display_stat = false, -- don't show file stat
            grouped = true, -- group initial sorting by directories and then files
            hidden = true, -- show hidden files
            hide_parent_dir = true, -- hide `../` in the file browser
            hijack_netrw = true, -- use telescope file browser when opening directory paths
            prompt_path = true, -- show the current relative path from cwd as the prompt prefix
            use_fd = true -- use `fd` instead of plenary, make sure to install `fd`
          },
        },
        picker = {
          find_files = {
            theme = "dropdown",
          }
        }
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, "file_browser")

      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fd', builtin.lsp_document_symbols, {})
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
      vim.keymap.set('n', "<leader>fx", builtin.treesitter, {})
      vim.keymap.set("n", "<leader>bf", ":Telescope file_browser<CR>", {})
      vim.keymap.set("n", "<leader>sf", function()
        builtin.lsp_document_symbols({
          symbols = { "Function", "Method", "Interface" }
        })
      end, { desc = "List functions in current file" })
    end,
  },
}
