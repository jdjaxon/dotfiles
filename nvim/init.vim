" Author: Jeremy Jackson

call plug#begin('~/.vim/plugged')
    Plug 'christianchiarulli/nvcode-color-schemes.vim'
    Plug 'nvim-treesitter/nvim-treesitter'
    " For file icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    " Using pre-built version without nodejs and yarn
    " add 'vim-plug' to the filetype list so vim-plug can update this plugin
    " see: https://github.com/iamcco/markdown-preview.nvim/issues/50
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'vim-airline/vim-airline'
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

" For when I typo :w to :W or etc.
command W w
command Q q
command WQ wq

" Set map leader to space
let mapleader=" "

" Lua configuration - temporary solution
lua << EOF
-- Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
} -- END OF TREESITTER

-- WEB DEVICONS
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
} -- END OF DEVICONS

-- nvim-tree setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_close = true,
  auto_reload_on_write = true,
  disable_netrw = false,
  hide_root_folder = false,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = nil,
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      git = false,
    },
  },
} -- END OF NVIM-TREE DEFAULT OPTIONS
EOF

" Mapping to toggle nvim-tree
map <leader>e :NvimTreeToggle<CR>

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

" Enables syntax highlighting
syntax on

" setting colorscheme
colorscheme nvcode

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