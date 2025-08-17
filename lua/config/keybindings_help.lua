-- keybindings_help.lua
local keymap_help = [[
[Keybindings]

<Leader>w    - Save file
<Leader>q    - Quit file (force)
<C-n>        - Quickfix: next item
<C-m>        - Quickfix: previous item
<Leader>a    - Quickfix: close list
<Leader>e    - Copy current file path to clipboard
<Leader>cc   - Remove search highlight
<leader>rw   - Rename word under cursor (global)
<C-j>        - Move to split below
<C-k>        - Move to split above
<C-h>        - Move to split left
<C-l>        - Move to split right
jj / jk      - Exit insert mode (faster alternative to Esc)
n / N        - Search next/previous and center line
*            - Search under cursor without jumping forward
gx           - Open URL under cursor in browser
<Leader>n    - Toggle NvimTree

[Go Tools]
:A           - Switch to alternate file (main <-> test)
:AV          - Open alternate file in vertical split
:AS          - Open alternate file in horizontal split

[LSP Keymaps]
gd           - Go to definition
<leader>v    - Go to definition (vertical split)
<leader>s    - Go to definition (horizontal split)
gr           - Find references
gD           - Go to declaration
K            - Show hover documentation
gi           - Go to implementation
<leader>cl   - Run code lens
<leader>rn   - Rename symbol
<leader>ca   - Code action (normal/visual)

[Terminal]
<M-j>        - Alt + j to toggle terminal
<D-j>        - Command + j (⌘+j) to toggle terminal

[Telescope]
<leader>ff   - Find files
<leader>fg   - Find live grep
<leader>fb   - Find buffer
<leader>fd   - Find document symbols
<leader>sf   - Find function, method or interface

]]

return keymap_help

