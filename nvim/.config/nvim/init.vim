" Author: Jeremy Jackson

" Needed by bufferline
set termguicolors

" Setting neovim's path to python3
let g:python3_host_prog = "/usr/bin/python3"

call plug#begin('~/.vim/plugged')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'numToStr/Comment.nvim'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'windwp/nvim-autopairs'
    " For luasnip.
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'
    """"""""""""""""""""""""
    Plug 'christianchiarulli/nvcode-color-schemes.vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-tree-docs'
    Plug 'lewis6991/gitsigns.nvim'
    " For file icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/bufferline.nvim'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'RRethy/vim-illuminate'
    " NOTE: make sure to save and source file and then run
    " `:call mkdp#util#install()` to finish setup.
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    """"""""""""""""""""""""""""""""""""
    Plug 'morhetz/gruvbox'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_show_hidden = 1
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'mbbill/undotree'
    Plug 'rust-lang/rust.vim'
call plug#end()

" For when I typo :w to :W or similar
command W w
command Q q
command WQ wq

" Set map leader to space
let mapleader=" "

lua require('user.cmp')
lua require('user.lsp')
lua require('user.comment')
lua require('user.autopairs')
lua require('user.nvim-tree')
lua require('user.treesitter')
lua require('user.keymaps')
lua require('user.web-devicons')
lua require('user.bufferline')
lua require('user.lualine')
lua require('user.toggleterm')
lua require('user.gitsigns')
lua require('user.illuminate')

" Enables syntax highlighting
syntax on
" configure nvcode-color-schemes
let g:nvcode_termcolors=256
colorscheme gruvbox

" Setting the neovim background to transparent
highlight Normal ctermbg=NONE guibg=NONE

" Checks for 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" Enable mouse
set mouse=a

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

" Markdown Preview shortcut
nnoremap <leader>mp :MarkdownPreview<CR>
nnoremap <leader>ms :MarkdownPreviewStop<CR>

" Commenting multiple lines
" NOTE: you will need to enter the commenting character
vnoremap <leader>/ :'<,'>norm I

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

" Sets a colored column at the 80-character limit
set colorcolumn=80

" Sets color of column
highlight ColorColumn ctermbg=NONE guibg=gray19

" Set vim leader to spacebar
map <Space> <C-w>


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
