" httpolors()
 
"
" ln vimrc ~/.vimrc

set nocompatible               " be iMproved
filetype off                   " required!

"set rtp+=/Users/willsp/usefulgits/powerline/powerline/bindings/vim
set laststatus=2
set t_Co=256

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'majutsushi/tagbar'
Bundle 'sjl/gundo.vim'
Bundle 'willsp/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'
Bundle 'lepture/vim-velocity'
Bundle 'lunaru/vim-less'
Bundle 'venusjs/venus.vim'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/syntastic'
Bundle 'kchmck/vim-coffee-script'
Bundle 'wavded/vim-stylus'
Bundle 'digitaltoad/vim-jade'
Bundle 'othree/html5.vim'
Bundle 'juvenn/mustache.vim'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'junegunn/goyo.vim'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'stephenmckinney/vim-solarized-powerline'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'tomtom/tcomment_vim'
" vim-scripts repos
Bundle 'bufexplorer.zip'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git' Problems with new version...
" trying silver searcher with ctrlp instead...
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

let mapleader = " "

" Ctrl-P options

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"let g:ctrlp_working_path_mode = 'ra' " Nearest ancestor with .git, .hg... then current file or current working dir
let g:ctrlp_working_path_mode = 'a' " It seems the r is having trouble with tetra... go figure. I'll figure it out... eventually...

map <Leader>t :CtrlP<cr>
map <Leader>w :Goyo<cr>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

" Sane tabs
set tabstop=4
set shiftwidth=4
set smartindent
set expandtab

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
set noerrorbells
set ruler
set viminfo=%,'50,\"100,/50,:100,h,n~/.viminfo
set spell spelllang=en_us

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

" Tagbar / Gundo
map <Leader>c :TagbarToggle<CR>
map <Leader>u :GundoToggle<CR>

" Colors
syntax enable
set background=dark

let g:solarized_termcolors=16
colorscheme solarized

" Setup toggle for remoting where others don't have solarized on their term
function! ToggleColors()
    if g:solarized_termcolors == 16
        let g:solarized_termcolors=256
        set background=dark
        colorscheme solarized
    else
        let g:solarized_termcolors=16
        set background=dark
        colorscheme solarized
    endif
endfunction

nnoremap <Leader>x :call ToggleColors()<cr>

