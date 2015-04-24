" httpolors()
 
"
" ln vimrc ~/.vimrc

set nocompatible               " be iMproved
filetype off                   " required!

"set rtp+=/Users/willsp/usefulgits/powerline/powerline/bindings/vim
set laststatus=2
set t_Co=256

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'Lokaltog/vim-easymotion'
Plugin 'avakarev/vim-watchdog'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'derekwyatt/vim-scala'
Plugin 'digitaltoad/vim-jade'
Plugin 'junegunn/goyo.vim'
Plugin 'juvenn/mustache.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'lepture/vim-velocity'
Plugin 'lunaru/vim-less'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'stephenmckinney/vim-solarized-powerline'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-surround'
Plugin 'venusjs/venus.vim'
Plugin 'wavded/vim-stylus'
Plugin 'willsp/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
" vim-scripts repos
"Plugin 'bufexplorer.zip'
" non github repos
" Plugin 'git://git.wincent.com/command-t.git' Problems with new version...
" trying silver searcher with ctrlp instead...
" git repos on your local machine (ie. when working on your own plugin)
"Plugin 'file:///Users/gmarik/path/to/plugin'
call vundle#end()

filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..
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
map <Leader>be :CtrlPBuffer<cr>

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
autocmd BufNewFile,BufReadPost *.md :set filetype=markdown

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
let g:bufExplorerShowTabBuffer=1

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

" EasyMotion Config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Arrow results navigation
nmap <silent> <RIGHT>           :cnext<CR>
nmap <silent> <RIGHT><RIGHT>    :cnfile<CR><C-G>
nmap <silent> <LEFT>            :cprev<CR>
nmap <silent> <LEFT><LEFT>      :cpfile<CR><C-G>

