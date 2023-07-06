" Author: Jeremy Jackson

call plug#begin('~/.vim/plugged')
    Plug 'christianchiarulli/nvcode-color-schemes.vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-tree-docs'
    " For file icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/toggleterm.nvim'
    " Using pre-built version without nodejs and yarn
    " add 'vim-plug' to the filetype list so vim-plug can update this plugin
    " see: https://github.com/iamcco/markdown-preview.nvim/issues/50
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'morhetz/gruvbox'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_show_hidden = 1
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'mbbill/undotree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rust-lang/rust.vim'
call plug#end()

" For when I typo :w to :W or similar
command W w
command Q q
command WQ wq

" Set map leader to space
let mapleader=" "

lua require('user.nvim-tree')
lua require('user.treesitter')
lua require('user.keymaps')
lua require('user.web-devicons')
lua require('user.lualine')
lua require('user.toggleterm')

" configure nvcode-color-schemes
let g:nvcode_termcolors=256


" Enables syntax highlighting
syntax on

" setting colorscheme
try
    colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
endtry

" Setting the neovim background to transparent
highlight Normal guibg=none

" Checks for 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" Set up for cursor crosshairs
set cursorline
set cursorcolumn

" Turns off the bells that tell me I'm doing things wrong.
set noerrorbells

" Set cursor to always appear as a block (personal preference)
set guicursor=

" When using both of these settings, the current line will be absolute, while
" all others are relative. With only relative, the current line is displayed
" as 0 (not very useful).
" Displays all line numbers relative to the current line
set relativenumber
" Displays absolute line numbers
set nu

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Use <tab> to trigger completion.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming shortcut
nmap <leader>rn <Plug>(coc-rename)

" Buffer navigation shortcuts
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>ex :Ex<CR>

" Markdown Preview shortcut
nnoremap <leader>mp :MarkdownPreview<CR>
nnoremap <leader>ms :MarkdownPreviewStop<CR>

" Commenting multiple lines
" NOTE: you will need to enter the commenting character
vnoremap <leader>/ :'<,'>norm I

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" vim normally highlights every occurence of your search pattern until to you
" tell it not to. This disables that.
set nohlsearch

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

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
set scrolloff=7

" Sets a column to the left of the numbers for debugging indicators. This
" isn't necessary if you aren't using a plugin for debugging.
"set signcolumn=yes

" Sets a colored column at the 80-character limit
"set colorcolumn=80

" Sets color of column
"highlight ColorColumn ctermbg=0 guibg=lightgrey

" Set vim leader to spacebar
map <Space> <C-w>

" Go-specific shortcuts
nnoremap <leader>gb :GoBuild<CR>
nnoremap <leader>gr :GoRun<CR>

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

"augroup SOURCING
"    autocmd!
"    autocmd BufWritePost ~/.config/nvim/init.vim source %
"augroup END
