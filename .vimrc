map ^[OA ^[ka
map ^[OB ^[ja
map ^[OC ^[la
map ^[OD ^[ha

set tabstop=4
set shiftwidth=4
set nowrap
set ai
set expandtab
set smartindent
set number

set statusline=%f%r\ \ char\ %3.3b\ \ encoding\ %{&encoding}\ \ %=\ \ %l:%c\ %P\ \ \
set laststatus=2

set nocompatible
set ruler
set showcmd
set showmode
set showmatch

syntax on
filetype plugin on

nmap <F2> :w<CR>
vmap <F2> <ESC>:w<CR>
imap <F2> <ESC>:w<CR>

nmap <F6> gt
vmap <F6> <ESC>gt<CR>
imap <F6> <ESC>gt<CR>

nmap <F9> :make<CR>
vmap <F9> <ESC>:make<CR>
imap <F9> <ESC>:make<CR>

nmap <F12> :cnext<CR>
vmap <F12> <ESC>:cnext<CR>
imap <F12> <ESC>:cnext<CR>

vmap < <gv
vmap > >gv

filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    :silent! %s#\($\n\s*\)\+\%$##
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
