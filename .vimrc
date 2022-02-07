" Mappings for arrows --------------------- {{{
map ^[OA ^[ka
map ^[OB ^[ja
map ^[OC ^[la
map ^[OD ^[ha
" }}}

" Basic settings -------------------------- {{{
set tabstop=4
set shiftwidth=4
set nowrap
set ai
set expandtab
set smartindent
set number

set nocompatible
set ruler
set showcmd
set showmode
set showmatch
" }}}

" Status line settings -------------------- {{{
set laststatus=2
set statusline=
set statusline+=%{g:custom_config_status} " Local config status
set statusline+=\ %f                      " File name
set statusline+=\ %r                      " Readonly flag
set statusline+=\ \ char\ 0x%-4.4B        " Character hex code
set statusline+=\ encoding\ %{&encoding}  " Buffer encoding
set statusline+=%=                        " Wrap line
set statusline+=FileType:\ %y             " Buffer type
set statusline+=\ \ Total\ lines:\ %-6L   " Total line count
set statusline+=\ %5P                     " Position in persent
set statusline+=\ %6l:%-3c                " Current position
" }}}

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

" Kill unnessesary spaces ----------------- {{{
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    :silent! %s#\($\n\s*\)\+\%$##
    call cursor(l, c)
endfun

augroup kill_garbage
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END
" }}}

" My personal preferences ----------------- {{{
let mapleader = ","
let maplocalleader = "\\"

augroup mustitz_helpers
    autocmd!
    autocmd BufRead,BufNewFile *.h set filetype=c
augroup END

" Fast ESC on keyboard
inoremap jk <esc>l

" Open & edit .vimrc on fly
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Uppercase after typing support
inoremap <leader>u <esc>viwU/\><cr>a
nnoremap <leader>u viwU/\><cr>

" Inserting a new line (*) at the beginning (*) go back to nmode after
inoremap <leader>gg <esc>ggi<cr><esc>ki
nnoremap OO O<esc>j
nnoremap oo o<esc>

" Commenting a line
autocmd FileType c,cpp nnoremap <localleader>c I//<esc>
autocmd FileType python nnoremap <localleader>c I#<esc>
autocmd FileType haskell nnoremap <localleader>c I--<esc>
" }}}

" Haskell group --------------------------- {{{
" Map to unicode symbols in Haskell
autocmd FileType haskell iabbrev <buffer> :: ∷
autocmd FileType haskell iabbrev <buffer> r- →
autocmd FileType haskell iabbrev <buffer> l- ←
autocmd FileType haskell iabbrev <buffer> r= ⇒
" }}}

" Vimscript file settings -------------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Local configuration files------------------------- {{{
fun! <SID>LoadCustomVimRC()

  fun! <SID>RecusiveLoadCustomVimRC(local_path)
    if a:local_path ==# '/'
      return ''
    endif
    let l:local_vimrc = a:local_path . '.vimrc'
    if l:local_vimrc ==# $MYVIMRC
      return ''
    endif
    if filereadable(l:local_vimrc)
      execute('source ' . l:local_vimrc)
      return l:local_vimrc
    endif
    let l:top_dir = simplify(a:local_path . '/../')
    return <SID>RecusiveLoadCustomVimRC(l:top_dir)
  endfun

  let l:local_path = fnamemodify('.', ':p')
  let l:fname = <SID>RecusiveLoadCustomVimRC(l:local_path)
  if strlen(l:fname) ==# 0
    let g:custom_config_status = "-cfg-"
  else
    let g:custom_config_status = "+cfg+"
  endif
  return l:fname
endfun

let g:custom_config_fname = <SID>LoadCustomVimRC()
" }}}
