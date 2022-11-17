"""""""""" general

autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"

set history=1000
set autoread

let mapleader = " "

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" UI
set number
set cursorline
set title
set ruler
set so=8
set mouse=a
set showmode

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set magic

" tab, indent
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set wrap

" clipboard
set clipboard+=unnamed

" statusline
set laststatus=2

" command line
set wildmenu
set showcmd

" files
set nobackup
set noswapfile

" brackets 
set showmatch

" buffer
set hidden

" bell
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" colorscheme
syntax enable

set background=dark
set encoding=utf8

"""""""""" keymaps

" auto left brackets
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" insert to cmd
inoremap <silent> jk <ESC>
inoremap <silent> kj <ESC>

" save & quit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :wq<CR>
nmap <leader>D :q!<CR>

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
" change insert mode status line color
""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""

" remember last cursor position
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

filetype on
