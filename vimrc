call pathogen#infect()
call pathogen#helptags()


syntax on
set nocompatible
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent
set smartindent
set et
set ai
set cin
set showmatch 
set hlsearch
set incsearch
set ignorecase
set smartcase
set splitbelow
set splitright
nnoremap <silent> <cr> :nohlsearch<cr><cr>

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"imap :!setxkbmap us:!setxkbmap us,ru
"nmap :!setxkbmap us:!setxkbmap us,ru
