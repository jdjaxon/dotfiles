" Author: Jeremy Jackson

" Enables syntax highlighting
syntax on
" Turns off the bells that tell me I'm doing things wrong.
set noerrorbells

" Set cursor to always appear as a block (personal preference)
set guicursor=

" When using both of these settings, the current line will be absolute, while
" all others are relative. With only relative, the current line is displayed
" as 0 (not very useful).
"
" Displays all line numbers relative to the current line
set relativenumber
" Displays absolute line numbers
set nu

" vim normally highlights every occurence of your search pattern until to you
" tell it not to. This disables that.
set nohlsearch

" It is best to have tabstop, softtabstop, and shiftwidth all set to the same
" value. vim sometimes requires additional settings if the values are not
" matched.
" If you have a file with a mix of tabs and spaces and you need to change it
" all to spaces, set these options in your .vimrc, open the file in vim, and
" run ':retab'. That will retab every line using the current configuration
" settings, specifically tabstop and expandtab.
"
" Sets the character width of each tab
set tabstop=4
" Sets the display width of each tab
set softtabstop=4
" Sets the spaceing for automatic indention and what happens when you use
" '>>', '<<', and '=='.
set shiftwidth=4
" Expands all tabs to spaces in respect to the values set above
set expandtab

" Simply determines indention level from syntax or current indention level.
set autoindent
" This is mostly for C-style programs, but may also work for other languages.
"set smartindent

" Disables swapfile creation. You may not want this to be disable if you are
" on a system where multiple users can access the same file.
set noswapfile
" Disables backup file creation
set nobackup
" Begins searching for even partial matches of search pattern
set incsearch
" Begins scrolling when you are eight lines from top or bottom of screen
set scrolloff=8

" Sets a column to the left of the numbers for debugging indicators. This
" isn't necessary if you aren't using a plugin for debugging.
set signcolumn=yes
" Sets a colored column at the 80-character limit
set colorcolumn=80
" Sets color of column
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Set vim leader to spacebar
map <Space> <C-w>

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'jremmen/vim-ripgrep'
    Plug 'tpope/vim-fugitive'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_show_hidden = 1
    Plug 'ycm-core/YouCompleteMe'
    let g:ycm_autoclose_preview_window_after_completion = 1
    Plug 'mbbill/undotree'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

" This function removes any trailing whitespace every time the current buffer
" (file) is saved.
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Autocommand group specifically for TrimWhiteSpace().
augroup PRUNING
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END
