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
          "gopls"
        },
        handlers = {
          function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
          end,
          ["gopls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup ({
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
                vim.api.nvim_create_authocmd("BufwritePre", {
                buffer = bufnr,
                callback = function()
                  -- Format the whole file
                  vim.lsp.buf.format({ timeout_ms = 2000, async = false })
                end -- end callback
                })
              end, -- end on attach
            })
          end -- end gopls
        },
      }
    end -- end config
}
