set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'willsp/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'
Bundle 'lepture/vim-velocity'
Bundle 'lunaru/vim-less'
Bundle 'venusjs/venus.vim'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/syntastic'
" vim-scripts repos
Bundle 'bufexplorer.zip'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"
" END VUNDLE

" Use , instead of \
let mapleader = ","

" Sane tabs
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Colors
syntax enable
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized

" Line numbers
set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunction

nnoremap <c-n> :call NumberToggle()<cr>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Swap jump to mark keys
nnoremap ' `
nnoremap ` '

" Fix % to work with more stuff
runtime macros/matchit.vim

" Command completion ++
set wildmenu

" Smarter searching
set ignorecase
set smartcase

" Backup to set directory instead of current
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Clear search
:command! C let @/=""

" Set whitespace characters when list
set listchars=tab:>-,trail:.,extends:>

" remap jj kk hh lll in insert to go to normal
inoremap jk <esc>
inoremap jj <esc>jj
inoremap kk <esc>kk
inoremap hh <esc>hh
inoremap lll <esc>lll

" Filetype settings
autocmd BufRead,BufNewFile inline.html,config.html :set filetype=velocity
autocmd BufRead,BufNewFile *.json :set filetype=javascript
autocmd BufRead,BufNewFile *.aspx :set filetype=html
autocmd BufRead,BufNewFile *.less :set filetype=less
autocmd BufRead,BufNewFile afiedt.buf :set filetype=sql

" Misc options
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set hidden
set history=1000
set hlsearch
set incsearch
set mouse=a
set scrolloff=3
set title
set visualbell

" Tab Autocomplete... FTW!!!
function! InsertTabWrapper()
    let col = col(".") - 1
    if !col || getline(".")[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>

" Code folding
set foldmethod=syntax
set foldlevelstart=1

let javaScript_fold=1

" Perforce...
nnoremap @p4e :!p4 edit '%'<cr>
nnoremap @p4r :!p4 revert '%'<cr>
nnoremap @p4s :!p4 submit '%'<cr>
nnoremap @p4a :!p4 add '%'<cr>

" Syntastic Options
let g:syntastic_always_populate_loc_list=1

" On by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': ['html'] }
