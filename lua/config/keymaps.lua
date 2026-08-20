-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


-- Fast saving
vim.keymap.set('n', '<Leader>w', ':write!<CR>')
vim.keymap.set('n', '<Leader>q', ':q!<CR>', { silent = true })



-- Some useful quickfix shortcuts for quickfix
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-m>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>a', '<cmd>cclose<CR>')



-- Copy current filepath to system clipboard
vim.keymap.set('n', '<Leader>e', ":let @+ = expand('%:p')<CR>", { silent = true })



-- Remove search highlight
vim.keymap.set('n', '<Leader>cc', ':nohlsearch<CR>')



-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
vim.keymap.set("x", "p", "\"_dP")



-- rename the word under the cursor 
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])



-- Better split switching between windows
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')



-- Exit on jj and jk
-- Vim trick to avoid reaching for the Esc key while typing.
-- It’s faster and keeps your hands on the home row.
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')



-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
-- n: go to next search match
-- N: go to previous match
vim.keymap.set('n', 'n', 'nzzzv', {noremap = true})
vim.keymap.set('n', 'N', 'Nzzzv', {noremap = true})



-- Don't jump forward if I higlight and search for a word
local function stay_star()
  local sview = vim.fn.winsaveview()
  local args = string.format("keepjumps keeppatterns execute %q", "sil normal! *")
  vim.api.nvim_command(args)
  vim.fn.winrestview(sview)
end
vim.keymap.set('n', '*', stay_star, {noremap = true, silent = true})



-- we don't use netrw (because of nvim-tree), hence re-implement gx to open
-- links in browser
--vim.keymap.set("n", "gx", '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>')
local function open_in_browser()
  local url = vim.fn.expand("<cfile>")
  vim.fn.jobstart({ "powershell.exe", "start", url }, { detach = true })
end
vim.keymap.set("n", "gx", open_in_browser,{ silent = true })



-- Open help window in a vertical split to the right.
-- Instead of appearing below your current window (default behavior)
-- It will now open on the right side, giving more horizontal space which is better for reading help.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})


-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
-- vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle!<CR>', { noremap = true })


-- vim-go
-- A: Switch to the alternate file (like main.go ↔ main_test.go) in the same window.
vim.api.nvim_create_user_command("A", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'edit'})<CR>", {})
-- AV: Open the alternate file in a vertical split.
vim.api.nvim_create_user_command("AV", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'vsplit'})<CR>", {})
-- AS: Open the alternate file in a horizontal split.
vim.api.nvim_create_user_command("AS", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'split'})<CR>", {})



-- Go uses gofmt, which uses tabs for indentation and spaces for aligment.
-- Hence override our indentation rules.
vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('setIndent', { clear = true }),
  pattern = { 'go' },
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4'
})



-- Go uses gofmt, which uses tabs for indentation and spaces for aligment.
-- Hence override our indentation rules.
vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('setIndent', { clear = true }),
  pattern = { 'go' },
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4'
})



-- automatically resize all vim buffers if I resize the terminal window
vim.api.nvim_command('autocmd VimResized * wincmd =')



-- https://github.com/neovim/neovim/issues/21771
local exitgroup = vim.api.nvim_create_augroup('setDir', { clear = true })
vim.api.nvim_create_autocmd('DirChanged', {
  group = exitgroup,
  pattern = { '*' },
  command = [[call chansend(v:stderr, printf("\033]7;file://%s\033\\", v:event.cwd))]],
})

vim.api.nvim_create_autocmd('VimLeave', {
  group = exitgroup,
  pattern = { '*' },
  command = [[call chansend(v:stderr, "\033]7;\033\\")]],
})



-- put quickfix window always to the bottom
local qfgroup = vim.api.nvim_create_augroup('changeQuickfix', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'wincmd J',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'setlocal wrap',
})



-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})



-- disable diagnostics, I didn't like them
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end



-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    -- Direct LSP navigation (quick jumps)
    vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>s', "<cmd>belowright split | lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)

    -- Telescope-powered LSP (better for multiple results)
    vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    vim.keymap.set('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', opts)
    vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', opts)
    vim.keymap.set('n', '<leader>gy', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    -- Call hierarchy (who calls this? what does this call?)
    vim.keymap.set('n', '<leader>ci', '<cmd>Telescope lsp_incoming_calls<CR>', opts)
    vim.keymap.set('n', '<leader>co', '<cmd>Telescope lsp_outgoing_calls<CR>', opts)

    -- Actions
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- Jump back/forward (centered)
vim.keymap.set('n', '<C-o>', '<C-o>zz', { noremap = true, desc = "Jump back (centered)" })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { noremap = true, desc = "Jump forward (centered)" })



vim.api.nvim_create_user_command("Keymaps", function()
  local help = require("config.keybindings_help")
  local lines = help.get_lines()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  -- Close the window on 'q' or <Esc>
  vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = buf, nowait = true, silent = true })
  vim.keymap.set("n", "<Esc>", "<cmd>bd!<CR>", { buffer = buf, nowait = true, silent = true })

  -- Syntax highlighting for the buffer
  vim.api.nvim_buf_call(buf, function()
    vim.fn.matchadd("Title", "^┌─.*$")
    vim.fn.matchadd("Special", "<[^>]*>")
    vim.fn.matchadd("Special", ":[A-Z][A-Z]*")
    vim.fn.matchadd("Delimiter", "│")
  end)

  local width = math.min(help.get_width(), vim.o.columns - 4)
  local height = math.min(help.get_height(), vim.o.lines - 4)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
    title = " 󰌌 Kevin's Keymaps ",
    title_pos = "center",
    footer = " q/Esc to close ",
    footer_pos = "center",
  }
  vim.api.nvim_open_win(buf, true, opts)
end, {})
vim.keymap.set("n", "<leader>?", "<cmd>Keymaps<CR>", { desc = "Show keybindings" })



-- Toggles indent lines
vim.keymap.set("n", "<leader>i", "<cmd>IBLToggle<cr>", { noremap = true, silent = true, desc = "Toggle indent lines" })



-- Toggle preview with <leader>mp (markdown preview)
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })


-- Scan in the current buffer the old git path and replace for the new one
-- in the lm code base
vim.keymap.set("n", "<leader>ur", function()
  local replacements = {
    ["git.lifemiles.net/LM%-Integrator/integration%-libraries"] = "gitlab.com/lifemiles-it/lm-integrator/integration-libraries",
    ["git.lifemiles.net/lm%-go%-libraries/lifemiles%-go"] = "gitlab.com/lifemiles-it/lm-go-libraries/lifemiles-go",
    ["git.lifemiles.net/lm%-proxy%-core/xmlsvcwrapper"] = "gitlab.com/lifemiles-it/lm-proxy-core/xmlsvcwrapper"
  }

  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    local new_line = line
    for old, new in pairs(replacements) do
      new_line = new_line:gsub(old, new)
    end
    lines[i] = new_line
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  print("✅ URLs replaced!")
end, { desc = "Replace legacy URLs", noremap = true, silent = true })



-- Java
-- Maven keymaps
-- Find the Maven project root by walking up from the current buffer or cwd
-- to the nearest directory containing a pom.xml
local function find_maven_root()
  local bufdir = vim.fn.expand("%:p:h")
  local search = (bufdir ~= "" and bufdir) or vim.fn.getcwd()
  local current = search
  while current and current ~= "/" do
    if vim.fn.filereadable(current .. "/pom.xml") == 1 then
      return current
    end
    current = vim.fn.fnamemodify(current, ":h")
  end
  return nil
end

local function run_maven_command(cmd)
  local root = find_maven_root()
  if root then
    vim.cmd("TermExec cmd='mvn " .. cmd .. "' dir='" .. root .. "'")
  else
    vim.cmd("TermExec cmd='mvn " .. cmd .. "'")
  end
end

-- Common Maven commands
vim.keymap.set("n", "<leader>mb", function() run_maven_command("clean install") end, { desc = "Maven Build" })
vim.keymap.set("n", "<leader>mt", function() run_maven_command("test") end, { desc = "Maven Test" })
vim.keymap.set("n", "<leader>mk", function() run_maven_command("package") end, { desc = "Maven Package" })
vim.keymap.set("n", "<leader>mc", function() run_maven_command("clean") end, { desc = "Maven Clean" })
vim.keymap.set("n", "<leader>mr", function() run_maven_command("spring-boot:run") end, { desc = "Maven Run (Spring Boot)" })
vim.keymap.set("n", "<leader>mR", function() run_maven_command("compile exec:java -Dexec.mainClass=com.kmencos.ansipinblock.Application") end, { desc = "Maven Run (Java main class)" })
vim.keymap.set("n", "<leader>mi", function() run_maven_command("clean install -DskipTests") end, { desc = "Maven Install (Skip Tests)" })
vim.keymap.set("n", "<leader>md", function() run_maven_command("dependency:tree") end, { desc = "Maven Dependency Tree" })

-- Custom Maven command
vim.keymap.set("n", "<leader>mm", function()
  vim.ui.input({ prompt = "Maven command: ", default = "mvn " }, function(input)
    if input then
      vim.cmd("TermExec cmd='" .. input .. "'")
    end
  end)
end, { desc = "Maven Custom Command" })
