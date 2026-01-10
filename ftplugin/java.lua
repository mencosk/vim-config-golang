local jdtls = require("jdtls")

-- Determine OS and paths
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

-- Mason's jdtls installation path
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

-- Detect OS for config
local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
  os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "config_win"
end

local path_to_config = jdtls_path .. "/" .. os_config
local path_to_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Setup debugging bundles
local bundles = {}
local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"
if vim.fn.isdirectory(java_debug_path) == 1 then
  vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"))
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", path_to_jar,
    "-configuration", path_to_config,
    "-data", workspace_dir,
  },
  
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
        enabled = true,
      },
      -- Enable JavaDoc support
      contentProvider = {
        preferred = "fernflower" -- or "fernflower" for better decompilation
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "org.mockito.Mockito.*",
      },
    },
  },
  
  init_options = {
    bundles = bundles,
  },
  
  on_attach = function(client, bufnr)
    -- Setup debugging
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    
    -- Java-specific keymaps
    vim.keymap.set("n", "<leader>co", jdtls.organize_imports, { buffer = bufnr, desc = "Organize Imports" })
    vim.keymap.set("n", "<leader>cv", jdtls.extract_variable, { buffer = bufnr, desc = "Extract Variable" })
    vim.keymap.set("v", "<leader>cv", [[<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>]], { buffer = bufnr, desc = "Extract Variable" })
    -- vim.keymap.set("n", "<leader>cc", jdtls.extract_constant, { buffer = bufnr, desc = "Extract Constant" })
    vim.keymap.set("v", "<leader>cm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], { buffer = bufnr, desc = "Extract Method" })
    vim.keymap.set("n", "<leader>tc", jdtls.test_class, { buffer = bufnr, desc = "Test Class" })
    vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, { buffer = bufnr, desc = "Test Method" })

    -- Go to implementation
    vim.keymap.set("n", "<leader>xi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to Implementation" })
  end,
}

jdtls.start_or_attach(config)
