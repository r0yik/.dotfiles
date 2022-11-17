local o = vim.o

o.fileencoding = "utf-8"

-- color
o.termguicolor = true

-- UI
o.number = true
--o.numberwidth = 5
--o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.scrolloff = 10

-- clipboard
o.clipboard = "unnamedplus"

-- text
o.wrap = true
o.textwidth = 300

-- tab
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- indent
o.cindent = true
-- o.smartindent = true
o.autoindent = true

-- search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.inccommand = 'split'
o.magic = true

-- visual mode
o.virtualedit = 'block'

-- backspace
o.backspace = 'indent,eol,start'

-- buffer splitting
o.splitright = true
o.splitbelow = true

o.hidden = true

o.timeoutlen = 500

vim.cmd [[set iskeyword+=-]]
vim.cmd "set whichwrap+=<,>,[,],h,l"

vim.cmd [[let g:loaded_ruby_provider = 0]]
vim.cmd [[let g:loaded_perl_provider = 0]]
