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

let g:pymode_python = 'python3'

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"imap :!setxkbmap us:!setxkbmap us,ru
"nmap :!setxkbmap us:!setxkbmap us,ru

py3 import os; import sys; sys.executable=os.path.join(sys.prefix, 'bin/python3')

"=====================================================
" Python-mode settings
"=====================================================
" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
" провека кода после сохранения
let g:pymode_lint_write = 1

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0
