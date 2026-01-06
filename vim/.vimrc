"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Index Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Status line
"    -> Keybindings
"       -> Buffers, tabs and windows
"       -> Visual mode related
"       -> Editing mappings
"       -> Search
"       -> Spell checking
"       -> Misc
"    -> Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup                    " Turn backup off
set nowb
set noswapfile                  " Turnoff swap file
set expandtab                   " Use spaces instead of tabs
set smarttab                    " Be smart when using tabs ;)         
set shiftwidth=2                " 1 tab == 2 spaces
set tabstop=2                   " 1 tab == 2 spaces
set lbr tw=500                  " Linebreak on 500 characters
set ai                          " Auto indent
set si                          " Smart indent
set wrap                        " Wrap lines
set history=500                 " Sets how many lines of history VIM has to remember
set nocompatible                " Disable compatibility with vi which can cause unexpected issues.
set clipboard=unnamedplus       " Copy to clipboard
syntax enable                   " Enable syntax highlighting
" Enable filetype plugins.
filetype plugin on
filetype indent on
set autoread                    " Set to auto read when a file is changed from the outside
au FocusGained,BufEnter * silent! checktime


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number relativenumber       " Enable relative number
set so=7                        " Set 7 lines to the cursor - when moving vertically using j/k
set ruler                       " Always show current position
set cmdheight=1                 " Height of the command bar
set hid                         " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent  " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                  " Ignore case when searching
set smartcase                   " When searching try to be smart about cases
set hlsearch                    " Highlight search results
set incsearch                   " Makes search act like search in modern browsers
set lazyredraw                  " Don't redraw while executing macros (good performance config)
set magic                       " For regular expressions turn magic on
set showmatch                   " Show matching brackets when text indicator is over them
set mat=2                       " How many tenths of a second to blink when matching brackets
set wildmenu                    " Turn on the Wild menu
set foldcolumn=0                " Add a bit extra margin to the left
set timeoutlen=3000             " Kyepress timeout
set ttimeoutlen=1
set switchbuf=useopen,usetab,newtab
set showtabline=1               " Show tab line bar
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" Properly disable sound on errors on MacVim
if has("gui_macvim")
  autocmd GUIEnter * set vb t_vb=
endif
" Change cursor based on different modes
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[3 q"
let &t_ER = "\e[2 q"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors                 " Enable termgui
set regexpengine=0                " Set regular expression engine automatically
set encoding=UTF-8                " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac              " Use Unix as the standard file type
set t_Co=256                      " Enable 256 colors palette
" Enable RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif
" Setting theme
try
  colorscheme catppuccin_mocha
catch
  colorscheme habamax
endtry

hi Normal guibg=NONE ctermbg=NONE " Set background transparent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline+=%4*\ %{StatuslineMode()}\ %*                   "Vim mode
set statusline+=%2*%{b:git_branch}%*                           "Git Status
" set statusline+=%1*\ buff:%n\ %*                               "Buffer number
set statusline+=%1*\ \󰷉\ %f\ %*                                "File path
set statusline+=%1*%m%*                                        "Modified flag
set statusline+=%1*\ %=\ %*                                    "Space between
" set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\       "Spellanguage & Highlight on?
set statusline+=%1*\ %P\ \|\ %L\ L\ %*                         "Line and column number
set statusline+=%5*\ \\ %y\ %*                                "File type
set statusline+=%3*\ %{&fenc!=''?&fenc:&enc}[%{&ff}]\ %*       "Encoding
set statusline+=%4*\ \ %{strftime('%H:%M')}\ %*               "Time string

"  Colors
hi User1 guibg=NONE guifg=#ffffff 
hi User2 guibg=#fab387 guifg=#000000
hi User3 guibg=#94e2d5 guifg=#000000
hi User4 guibg=#89b4fa guifg=#000000
hi User5 guibg=#f38ba8 guifg=#000000
hi User6 guibg=#6c7086 guifg=#ffffff


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
" Map the escape sequence <Esc>j to the Alt+j key (use <M-j> notation for mappings)
map <Esc>j <A-j>
map <Esc>k <A-k>

" ':W' sudo saves the file (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
nnoremap <leader>q :q<cr>
nnoremap <leader>R :so ~/.vimrc<cr>
" Clear search highlights
nnoremap <leader><esc> :noh<cr>
" Open file explorer
nnoremap <leader>e :Ex<cr>
" Ctrl + s to save file
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>
vnoremap <C-s> :w<cr>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Pageup/down will scroll half-page and center the current line on the screen
nmap     <silent> <C-u>      <C-U>zz
nmap     <silent> <C-d>      <C-D>zz
nnoremap <silent> <PageUp>   <C-u>
vnoremap <silent> <PageUp>   <C-u>
inoremap <silent> <PageUp>   <C-O><C-U><C-O>zz
nnoremap <silent> <PageDown> <C-d>
vnoremap <silent> <PageDown> <C-d>
inoremap <silent> <PageDown> <C-O><C-D><C-O>zz


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Buffers, windows and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :Bonly close all the buffers except current only
command! Bonly silent! execute "%bd|e#|bd#"
" Buffer navigation
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
" Close the current buffer
nnoremap <leader>bd :Bdelete<cr>
" Close all the buffers except current
nnoremap <leader>bo :Bonly<cr>
" Quickly open a buffer for scribble
nnoremap <leader>bN :e ~/tmp/vim/buffer<cr>
" Quickly open a markdown buffer for scribble
nnoremap <leader>bm :e ~/tmp/vim/buffer.md<cr>
" Switch CWD to the directory of the open buffer.
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Windows navigations
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <leader>w <C-W>
nnoremap <leader>\ :vsplit<cr>
nnoremap <leader>- :split<cr>

" Tabs navigations
nnoremap <S-l> :tabn<cr>
nnoremap <S-h> :tabp<cr>
nnoremap <tab> :tabn<cr>
nnoremap <S-tab> :tabp<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tm :tabmove
" Toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" better indenting
vnoremap < :<<cr>gv
vnoremap > :><cr>gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Command+[jk] on mac
nnoremap <A-j> :m.+1<cr>
nnoremap <A-k> :m.-2<cr>
inoremap <A-j> <esc>:m.+1<cr>
inoremap <A-k> <esc>:m.-2<cr>
vnoremap <A-j> :m'>+1<cr>gv=gv
vnoremap <A-k> :m'<-2<cr>gv=gv
" Return to last edit position when opening files.
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" find files with fzf 
nnoremap <leader>ff :Files<cr>
" Grep search word with fzf 
nnoremap <leader>fg :Rg<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
function! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" :Bdelete Don't close window, when deleting a buffer
command! Bdelete call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" :Files
command! Files call FZF()
function! FZF() abort
  let l:tempname = tempname()
  " fzf | awk '{ print $1":1:0" }' > file
  execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
  try
    execute 'cfile ' . l:tempname
    redraw!
  finally
    call delete(l:tempname)
  endtry
endfunction

" :Rg [pattern]
command! -nargs=* Rg call RG(<q-args>)
function! RG(args) abort
  let l:tempname = tempname()
  let l:pattern = '.'
  if len(a:args) > 0
    let l:pattern = a:args
  endif
  " rg --vimgrep <pattern> | fzf -m > file
  execute 'silent !rg --vimgrep ''' . l:pattern . ''' | fzf -m > ' . fnameescape(l:tempname)
  try
    execute 'cfile ' . l:tempname
    redraw!
  finally
    call delete(l:tempname)
  endtry
endfunction

" Git status
fun! GitBranch(file)
  let l:dir = fnamemodify(system('readlink -f ' . a:file), ':h')
  let l:cmd = 'git -C ' . l:dir . ' branch --show-current 2>/dev/null'
  let b:git_branch = "  " .. trim(system(l:cmd)) .. " "
endfun

augroup GitBranch
  autocmd!
  autocmd BufEnter,ShellCmdPost,FileChangedShellPost * call GitBranch(expand('%'))
augroup END

" Mode
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==#"V"
    return "VISUAL LINE"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode ==# "\<C-V>"
  return "V-BLOCK"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  else
    return "VIM"
  endif
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

