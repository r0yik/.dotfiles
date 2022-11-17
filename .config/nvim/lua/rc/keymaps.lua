local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- jk/kj to insert to normal
keymap('i', 'jk', '<ESC>', opts)
keymap('i', 'kj', '<ESC>', opts)

-- highlight previous highlight
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- bufferline
vim.cmd [[
    nnoremap <silent><TAB> :BufferLineCycleNext<CR>
    nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
]]
