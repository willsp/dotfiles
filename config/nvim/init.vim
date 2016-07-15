let g:settings = get(g:, 'settings', {})
if filereadable(expand("~/.cache/vimfiles/dein/repos/github.com/Shougo/dein.vim/README.md"))
    let g:settings.dein_installed = 1
else
    if executable('git')
        exec '!git clone https://github.com/Shougo/dein.vim '
                    \ . '~/.cache/vimfiles/dein/repos/github.com/Shougo/dein.vim'
        let g:settings.dein_installed = 1
    else
        echohl WarningMsg | echom "You need install git!" | echohl None
    endif
endif
set runtimepath+=~/.cache/vimfiles/dein/repos/github.com/Shougo/dein.vim " path to dein.vim

set t_Co=256

set clipboard=unnamed
set hidden
set history=1000
set laststatus=2
set ruler
set scrolloff=3
set title

" Spelling
set spell spelllang=en_us

" Sane tabs
set tabstop=4
set shiftwidth=4
set smartindent
set expandtab

" Line numbers
set number relativenumber
:au FocusLost * :set number norelativenumber
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set relativenumber

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

set fillchars+=diff:⣿
set fillchars+=vert:│
set fillchars+=fold:-

" A visual cue for line-wrapping.
let &showbreak = '↪ '
set wrap

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" Visual cues when in 'list' model.
set listchars+=eol:¬
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=nbsp:⋅
set listchars+=tab:\|\ 

" Keep some spacing.
set sidescrolloff=1

" Filetype settings
autocmd BufRead,BufNewFile inline.html,config.html :set filetype=velocity
autocmd BufRead,BufNewFile *.json :set filetype=javascript
autocmd BufRead,BufNewFile *.aspx :set filetype=html
autocmd BufRead,BufNewFile *.less :set filetype=less
autocmd BufRead,BufNewFile afiedt.buf :set filetype=sql
autocmd BufNewFile,BufReadPost *.md :set filetype=markdown
autocmd BufRead,BufNewFile *.txt,*.asciidoc,README,TODO,CHANGELOG,NOTES,ABOUT
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=75 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

let mapleader = " "

map <Leader>t :CtrlP<cr>
map <Leader>w :Goyo<cr>
map <Leader>be :CtrlPBuffer<cr>
map <Leader>u :MundoToggle<CR>
map <Leader>n :NERDTreeToggle<CR>

" Swap jump to mark keys
nnoremap ' `
nnoremap ` '

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Arrow results navigation
nmap <silent> <RIGHT>           :cnext<CR>
nmap <silent> <RIGHT><RIGHT>    :cnfile<CR><C-G>
nmap <silent> <LEFT>            :cprev<CR>
nmap <silent> <LEFT><LEFT>      :cpfile<CR><C-G>

" Perforce...
nnoremap @p4e :!p4 edit '%'<cr>
nnoremap @p4r :!p4 revert '%'<cr>
nnoremap @p4s :!p4 submit '%'<cr>
nnoremap @p4a :!p4 add '%'<cr>

" remap jj kk hh lll in insert to go to normal
inoremap jk <esc>
inoremap jj <esc>jj
inoremap kk <esc>kk
inoremap hh <esc>hh
inoremap lll <esc>lll

" Arrow results navigation
nmap <silent> <RIGHT>           :cnext<CR>
nmap <silent> <RIGHT><RIGHT>    :cnfile<CR><C-G>
nmap <silent> <LEFT>            :cprev<CR>
nmap <silent> <LEFT><LEFT>      :cpfile<CR><C-G>

" Ctrl-P options

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"let g:ctrlp_working_path_mode = 'ra' " Nearest ancestor with .git, .hg... then current file or current working dir
let g:ctrlp_working_path_mode = 'ra' " It seems the r is having trouble with tetra... go figure. I'll figure it out... eventually...

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Makers
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_less_enabled_makers = ['lessc']
let g:neomake_html_tidy5_maker = {
    \ 'args': ['-e', '-q', '--gnu-emacs', 'true'],
    \ 'errorformat': '%A%f:%l:%c: Warning: %m',
    \ }
let g:neomake_html_enabled_makers = ['tidy5']

if $TMUX != '' 
  " integrate movement between tmux/vim panes/windows

  fun! TmuxMove(direction)
    " Check if we are currently focusing on a edge window.
    " To achieve that,  move to/from the requested window and
    " see if the window number changed
    let oldw = winnr()
    silent! exe 'wincmd ' . a:direction
    let neww = winnr()
    silent! exe oldw . 'wincmd'
    if oldw == neww
      " The focused window is at an edge, so ask tmux to switch panes
      if a:direction == 'j'
        call system("tmux select-pane -D")
      elseif a:direction == 'k'
        call system("tmux select-pane -U")
      elseif a:direction == 'h'
        call system("tmux select-pane -L")
      elseif a:direction == 'l'
        call system("tmux select-pane -R")
      endif
    else
      exe 'wincmd ' . a:direction
    end
  endfun

  nnoremap <silent> <c-w>j :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w>k :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w>h :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w>l :silent call TmuxMove('l')<cr>

  " Quickly restart your debugger/console/webserver. Eg: if you are developing a node.js web app
  " in the 'serve.js' file you can quickly restart the server with this mapping:
  nnoremap <silent> <f5> :call SlimuxSendKeys('C-C " node serve.js" Enter')<cr>
  " pay attention to the space before 'node', this is actually required as send-keys will eat the first key

endif

autocmd! BufWritePost * Neomake
call dein#begin(expand('~/.cache/dein'))

call dein#add(expand('~/.cache/vimfiles/dein/repos/github.com/Shougo/dein.vim'))

call dein#add('tpope/vim-fugitive')
call dein#add('Valloric/YouCompleteMe')
call dein#add('airblade/vim-gitgutter')
call dein#add('avakarev/vim-watchdog')
call dein#add('benekastah/neomake')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('janko-m/vim-test')
call dein#add('kien/ctrlp.vim')
call dein#add('lepture/vim-velocity')
call dein#add('mattn/emmet-vim')
call dein#add('sheerun/vim-polyglot')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-surround')
call dein#add('willsp/vim-colors-solarized')
call dein#add('groenewege/vim-less',                    { 'on_ft':['less']})
call dein#add('hail2u/vim-css3-syntax',                 { 'on_ft':['css','scss','sass']})
call dein#add('ap/vim-css-color',                       { 'on_ft':['css','scss','sass','less','styl']})
call dein#add('othree/html5.vim',                       { 'on_ft':['html']})
call dein#add('juvenn/mustache.vim',                    { 'on_ft':['mustache']})
call dein#add('Valloric/MatchTagAlways',                { 'on_ft':['html' , 'xhtml' , 'xml' , 'jinja']})
call dein#add('pangloss/vim-javascript',                { 'on_ft':['javascript']})
call dein#add('mmalecki/vim-node.js',                   { 'on_ft':['javascript']})
call dein#add('leshill/vim-json',                       { 'on_ft':['javascript','json']})
call dein#add('othree/javascript-libraries-syntax.vim', { 'on_ft':['javascript','coffee','ls','typescript']})
call dein#add('itchyny/calendar.vim',                   { 'on_cmd' : 'Calendar'})
call dein#add('junegunn/goyo.vim',                      { 'on_cmd' : 'Goyo'})
call dein#add('scrooloose/nerdtree',                    { 'on_cmd' : 'NERDTreeToggle'})
call dein#add('simnalamburt/vim-mundo',                 { 'on_cmd' : 'MundoToggle'})
call dein#add('junegunn/gv.vim',                        { 'on_cmd' : 'GV'})
call dein#add('lambdalisue/vim-gita',                   {'on_cmd': 'Gita'})

call dein#end()

" Colors
syntax enable
set background=dark

" let g:solarized_termcolors=256
" let g:solarized_visibility =  "low"
" let s:terminal_italic=1
colorscheme solarized

" Escape/unescape & < > HTML entities in range (default current line).
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
command! Colors call ToggleColors()
noremap <silent> <Leader>h :Entities 0<CR>
noremap <silent> <Leader>H :Entities 1<CR>

" " https://github.com/wsdjeg/DotFiles/blob/master/config/nvim/config/neovim.vim
" function! s:GetVisual()
"     let [lnum1, col1] = getpos("'<")[1:2]
"     let [lnum2, col2] = getpos("'>")[1:2]
"     let lines = getline(lnum1, lnum2)
"     let lines[-1] = lines[-1][:col2 - 2]
"     let lines[0] = lines[0][col1 - 1:]
"     return lines
" endfunction
"
" function! REPLSend(lines)
"     call jobsend(g:last_terminal_job_id, add(a:lines, ''))
" endfunction
" " }}}
" " Commands {{{
" " REPL integration {{{
" command! -range=% REPLSendSelection call REPLSend(s:GetVisual())
" command! REPLSendLine call REPLSend([getline('.')])
" " }}}
" "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" "let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" "silent! let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" "silent! let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" "silent! let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" " dark0 + gray
" let g:terminal_color_0 = "#282828"
" let g:terminal_color_8 = "#928374"
"
" " neutral_red + bright_red
" let g:terminal_color_1 = "#cc241d"
" let g:terminal_color_9 = "#fb4934"
"
" " neutral_green + bright_green
" let g:terminal_color_2 = "#98971a"
" let g:terminal_color_10 = "#b8bb26"
"
" " neutral_yellow + bright_yellow
" let g:terminal_color_3 = "#d79921"
" let g:terminal_color_11 = "#fabd2f"
"
" " neutral_blue + bright_blue
" let g:terminal_color_4 = "#458588"
" let g:terminal_color_12 = "#83a598"
"
" " neutral_purple + bright_purple
" let g:terminal_color_5 = "#b16286"
" let g:terminal_color_13 = "#d3869b"
"
" " neutral_aqua + faded_aqua
" let g:terminal_color_6 = "#689d6a"
" let g:terminal_color_14 = "#8ec07c"
"
" " light4 + light1
" let g:terminal_color_7 = "#a89984"
" let g:terminal_color_15 = "#ebdbb2"
" augroup Terminal
"     au!
"     au TermOpen * let g:last_terminal_job_id = b:terminal_job_id | IndentLinesDisable
"     au WinEnter term://* startinsert | IndentLinesDisable
"     "au TermClose * exec &buftype == 'terminal' ? 'bd!' :  ''
"     au TermClose * exe expand('<abuf>').'bd!'
" augroup END

autocmd BufEnter,WinEnter,InsertLeave * set cursorline
autocmd BufLeave,WinLeave,InsertEnter * set nocursorline

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
" }}}
