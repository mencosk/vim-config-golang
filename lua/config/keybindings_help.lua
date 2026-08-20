-- keybindings_help.lua
local M = {}

M.sections = {
  {
    title = "General",
    keys = {
      { "<Leader>w", "Save file" },
      { "<Leader>q", "Quit file (force)" },
      { "<Leader>e", "Copy current file path to clipboard" },
      { "<Leader>cc", "Remove search highlight" },
      { "<Leader>rw", "Rename word under cursor (global)" },
      { "<Leader>n", "Toggle NvimTree" },
      { "<Leader>i", "Toggle indent lines" },
      { "<Leader>?", "Show this help" },
    },
  },
  {
    title = "Navigation",
    keys = {
      { "<C-j>", "Move to split below" },
      { "<C-k>", "Move to split above" },
      { "<C-h>", "Move to split left" },
      { "<C-l>", "Move to split right" },
      { "jj / jk", "Exit insert mode" },
      { "n / N", "Search next/prev (centered)" },
      { "*", "Search word under cursor (no jump)" },
      { "gx", "Open URL under cursor in browser" },
    },
  },
  {
    title = "Quickfix",
    keys = {
      { "<C-n>", "Next item" },
      { "<C-m>", "Previous item" },
      { "<Leader>a", "Close quickfix list" },
    },
  },
  {
    title = "LSP (Direct)",
    keys = {
      { "gd", "Go to definition" },
      { "<Leader>v", "Definition in vertical split" },
      { "<Leader>s", "Definition in horizontal split" },
      { "gr", "Find references" },
      { "gD", "Go to declaration" },
      { "K", "Hover documentation" },
      { "gi", "Go to implementation" },
      { "gy", "Go to type definition" },
      { "<C-o>", "Jump back (centered)" },
      { "<C-i>", "Jump forward (centered)" },
    },
  },
  {
    title = "LSP (Telescope)",
    keys = {
      { "<Leader>gd", "Definitions (picker)" },
      { "<Leader>gi", "Implementations (picker)" },
      { "<Leader>gr", "References (picker)" },
      { "<Leader>gy", "Type definitions (picker)" },
      { "<Leader>ci", "Incoming calls" },
      { "<Leader>co", "Outgoing calls" },
    },
  },
  {
    title = "LSP Actions",
    keys = {
      { "<Leader>cl", "Run code lens" },
      { "<Leader>rn", "Rename symbol" },
      { "<Leader>ca", "Code action" },
    },
  },
  {
    title = "Telescope",
    keys = {
      { "<Leader>ff", "Find files" },
      { "<Leader>fg", "Live grep" },
      { "<Leader>fb", "Find buffer" },
      { "<Leader>fh", "Help tags" },
      { "<Leader>fd", "Document symbols" },
      { "<Leader>fs", "Grep string under cursor" },
      { "<Leader>fx", "Treesitter symbols" },
      { "<Leader>bf", "File browser" },
      { "<Leader>sf", "Functions/Methods/Interfaces" },
    },
  },
  {
    title = "Go Tools",
    keys = {
      { ":A", "Switch to alternate file (main ↔ test)" },
      { ":AV", "Alternate in vertical split" },
      { ":AS", "Alternate in horizontal split" },
    },
  },
  {
    title = "Maven (Java)",
    keys = {
      { "<Leader>mb", "Maven clean install" },
      { "<Leader>mt", "Maven test" },
      { "<Leader>mk", "Maven package" },
      { "<Leader>mc", "Maven clean" },
      { "<Leader>mr", "Maven spring-boot:run" },
      { "<Leader>mR", "Maven run (Java main class)" },
      { "<Leader>mi", "Maven install (skip tests)" },
      { "<Leader>md", "Maven dependency tree" },
      { "<Leader>mm", "Maven custom command" },
    },
  },
  {
    title = "Terminal",
    keys = {
      { "<M-j>", "Toggle terminal (Alt+j)" },
    },
  },
  {
    title = "Git",
    keys = {
      { "]c", "Next git hunk" },
      { "[c", "Previous git hunk" },
    },
  },
  {
    title = "Markdown",
    keys = {
      { "<Leader>mp", "Toggle Markdown preview" },
    },
  },
  {
    title = "Misc",
    keys = {
      { "<Leader>ur", "Replace legacy LM URLs" },
      { "p (visual)", "Paste without replacing clipboard" },
    },
  },
}

function M.get_lines()
  local lines = {}
  local max_key_len = 0

  -- Calculate max key length for alignment
  for _, section in ipairs(M.sections) do
    for _, keymap in ipairs(section.keys) do
      max_key_len = math.max(max_key_len, #keymap[1])
    end
  end

  for i, section in ipairs(M.sections) do
    if i > 1 then
      table.insert(lines, "")
    end
    table.insert(lines, "┌─ " .. section.title .. " " .. string.rep("─", 40 - #section.title))
    for _, keymap in ipairs(section.keys) do
      local padding = string.rep(" ", max_key_len - #keymap[1] + 2)
      table.insert(lines, "│ " .. keymap[1] .. padding .. keymap[2])
    end
  end

  return lines
end

function M.get_width()
  local lines = M.get_lines()
  local max_width = 0
  for _, line in ipairs(lines) do
    max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
  end
  return max_width + 4
end

function M.get_height()
  return #M.get_lines() + 2
end

return M

