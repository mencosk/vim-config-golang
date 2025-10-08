return {
    "neovim/nvim-lspconfig",
    dependencies = {
      {"mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup{
        ensure_installed = {
          "lua_ls",
          "gopls",
          "pyright",
          "jdtls",
          "dockerls",
          "html",
          "cssls",
          "ts_ls"
        },
        handlers = {
          -- Default handler using the new API
          function (server_name, lsp)
            lsp.setup {}
          end,
          ["gopls"] = function(server_name, lsp)
            lsp.setup ({
              settings = {
                gopls = {
                  -- Code analysis settings for better diagnostics
                  analyses = {
                    unusedparams = true,    -- Check for unused parameters
                    shadow = true,          -- Check for shadowed variables
                    nilness = true,         -- Check for nil dereferences
                    unusedwrite = true,     -- Check for unused writes
                    useany = true,          -- Check for interface{} usage
                    unusedImports = true,   -- Check for unused imports
                  },
                  staticcheck = true,       -- Enable static analysis
                  gofumpt = true,           -- Format with stricter rules
                  usePlaceholders = true,   -- Fill in function parameters
                  completeUnimported = true,  -- Auto-import packages as you type
                  semanticTokens = true,      -- Better syntax highlighting
                },
              },
              -- configure behavior when gopls attaches to a buffer
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    -- Format the whole file
                    vim.lsp.buf.format({ timeout_ms = 2000, async = false })
                  end -- end callback
                })
              end, -- end on attach
            })
          end, -- end gopls
          ["ts_ls"] = function(server_name, lsp)
            lsp.setup({
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayFunctionParameterTypeHints = true,
                  }
                }
              }
            })
          end, -- end ts_ls
        },
      }
    end -- end config
}
