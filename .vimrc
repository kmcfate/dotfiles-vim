" .vimrc of Bart Trojanowski
"
" You can get a more upto date version from
"   http://www.jukie.net/~bart/conf/vimrc
"
" Most files sourced by this vimrc are located here:
"   http://www.jukie.net/~bart/conf/vim/
"

" ---------------------------------------------------------------------------
" first the disabled features due to security concerns
set modelines=5         " no modelines [http://www.guninski.com/vim1.html]
"let g:secure_modelines_verbose=1 " securemodelines vimscript

" ---------------------------------------------------------------------------
" configure other scripts

let c_no_curly_error = 1

" ---------------------------------------------------------------------------
" operational settings
" set list lcs=tab:>-,eol:Ꞁ,trail:~,extends:>,precedes:<
set nocompatible                " vim defaults, not vi!
syntax on                       " syntax on
set hidden                      " allow editing multiple unsaved buffers
set more                        " the 'more' prompt
filetype on                     " automatic file type detection
set autoread                    " watch for file changes by other programs
set visualbell                  " visual beep
set backup                      " produce *~ backup files
set backupext=~                 " add ~ to the end of backup files
set backupdir=~/.vim/backups
set directory=~/.vim/tmp
" set patchmode=.orig                " only produce *~ if not there
set noautowrite                 " don't automatically write on :next, etc
let maplocalleader='~'          " all my macros start with ,
set wildmenu                    " : menu has tab completion, etc
set scrolloff=5                 " keep at least 5 lines above/below cursor
set sidescrolloff=5             " keep at least 5 columns left/right of cursor
set history=200                 " remember the last 200 commands
set pastetoggle=<F10>
map <F9> :Hexmode<cr>
map <F8> :%!xxd -r<cr>
map <F11> :Tabularize /=><cr>
" ---------------------------------------------------------------------------
" meta
map <LocalLeader>ce :edit ~/.vimrc<cr>          " quickly edit this file
map <LocalLeader>cs :source ~/.vimrc<cr>        " quickly source this file

" ---------------------------------------------------------------------------
" window spacing
set cmdheight=2                 " make command line two lines high
set ruler                       " show the line number on bar
set lazyredraw                  " don't redraw when running macros
"set number                      " show line number on each line
"set winheight=999               " maximize split windows
"set winminheight=0              " completely hide other windws

map <LocalLeader>w+ 100<C-w>+  " grow by 100
map <LocalLeader>w- 100<C-w>-  " shrink by 100

" ---------------------------------------------------------------------------
" mouse settings
" set mouse=a                     " mouse support in all modes
" set mousehide                   " hide the mouse when typing text

" ,p and shift-insert will paste the X buffer, even on the command line
" nmap <LocalLeader>p i<S-MiddleMouse><ESC>
" imap <S-Insert> <S-MiddleMouse>
" cmap <S-Insert> <S-MiddleMouse>

" this makes the mouse paste a block of text without formatting it 
" (good for code)
" map <MouseMiddle> <esc>"*p
" toggle between terminal and vim mouse
map <silent><F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
imap <silent><F12> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
function ShowMouseMode()
    if (&mouse == 'a')
        echo "mouse-vim"
    else
        echo "mouse-xterm"
    endif
endfunction
" ---------------------------------------------------------------------------
" global editing settings
set list
set autoindent smartindent      " turn on auto/smart indenting
set expandtab                   " use spaces, not tabs
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=4                   " tabstops of 8
set softtabstop=4              " tabstops of 8
set shiftwidth=4                " indents of 8
" set cinkeys=0{,0},:,0#,!,!^F
set backspace=eol,start,indent  " allow backspacing over indent, eol, & start
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo

" ---------------------------------------------------------------------------
" searching...
set hlsearch                   " enable search highlight globally
set incsearch                  " show matches as soon as possible
set showmatch                  " show matching brackets when typing
" disable last one highlight
nmap <LocalLeader>nh :nohlsearch<cr>
nmap <silent> <C-N> :silent noh<CR>

set diffopt=filler,iwhite       " ignore all whitespace and sync

" ---------------------------------------------------------------------------
" spelling...
if v:version >= 700
    let b:lastspelllang='en'
    function! ToggleSpell()
        if &spell == 1
            let b:lastspelllang=&spelllang
            setlocal spell!
        elseif b:lastspelllang
            setlocal spell spelllang=b:lastspelllang
        else
            setlocal spell spelllang=en
        endif
    endfunction

    nmap <LocalLeader>ss :call ToggleSpell()<CR>

    setlocal spell spelllang=en
    setlocal nospell
endif

" ---------------------------------------------------------------------------
" some useful mappings

" disable search complete
let loaded_search_complete = 1

" Y yanks from cursor to $
map Y y$
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
set listchars=tab:>-,trail:.,extends:>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>
" change directory to that of current file
nmap <LocalLeader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <LocalLeader>lcd :lcd%:p:h<cr>

" word swapping
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>
" char swapping
nmap <silent> gc xph

" save and build
nmap <LocalLeader>wm  :w<cr>:make<cr>

" this is for the find function plugin
nmap <LocalLeader>ff :let name = FunctionName()<CR> :echo name<CR> 

" http://www.vim.org/tips/tip.php?tip_id=1022
"set foldmethod=expr 
"set foldexpr=getline(v:lnum)!~\"regex\" 

" ---------------------------------------------------------------------------
"  buffer management, note 'set hidden' above

" Move to next buffer
map <LocalLeader>bn :bn<cr>
" Move to previous buffer
map <LocalLeader>bp :bp<cr>
" List open buffers
map <LocalLeader>bb :ls<cr>

" ---------------------------------------------------------------------------
" when switching buffers, preserve window view

" function! MyWinSaveView()
"         if &diff 
"                 let b:winview = winsaveview()
"         endif
" endf
" function! MyWinRestoreView()
"         if &diff 
"                 if(exists('b:winview'))
"                         call winrestview(b:winview)
"                 endif
"         endif
" endf
"
" if v:version >= 700
"         au BufLeave * :call MyWinSaveView()
"         au BufEnter * :call MyWinRestoreView()
" endif 

" ---------------------------------------------------------------------------
" dealing with merge conflicts

" find merge conflict markers
:map <LocalLeader>fc /\v^[<=>]{7}( .*\|$)<CR>


" ---------------------------------------------------------------------------

function! OnlineDoc() 
    let s:browser = "firefox"
    let s:wordUnderCursor = expand("<cword>") 

    if &ft == "cpp" || &ft == "c" || &ft == "ruby" || &ft == "php" || &ft == "python" 
        let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor."+lang:".&ft
    elseif &ft == "vim"
        let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor
    else 
        return 
    endif 

    let s:cmd = "silent !" . s:browser . " " . s:url 
    "echo  s:cmd 
    execute  s:cmd 
    redraw!
endfunction 

" online doc search 
map <LocalLeader>k :call OnlineDoc()<CR>

" ---------------------------------------------------------------------------
" status line 
set laststatus=2
if has('statusline') && 0
    " Status line detail: (from Rafael Garcia-Suarez)
    " %f		file path
    " %y		file type between braces (if defined)
    " %([%R%M]%)	read-only, modified and modifiable flags between braces
    " %{'!'[&ff=='default_file_format']}
    "			shows a '!' if the file format is not the platform
    "			default
    " %{'$'[!&list]}	shows a '*' if in list mode
    " %{'~'[&pm=='']}	shows a '~' if in patchmode
    " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
    "			only for debug : display the current syntax item name
    " %=		right-align following items
    " #%n		buffer number
    " %l/%L,%c%V	line number, total number of lines, and column number
    "function! SetStatusLineStyle()
    "        if &stl == '' || &stl =~ 'synID'
    "                let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}" .
    "                                        \"%{'~'[&pm=='']}"                     .
    "                                        \"%=#%n %l/%L,%c%V "                   .
    "                                        \"git:%{call GitBranchInfoString()}"
    "        else
    "                let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}" .
    "                                        \" (%{synIDattr(synID(line('.'),col('.'),0),'name')})" .
    "                                        \"%=#%n %l/%L,%c%V "
    "        endif
    "endfunc
    "call SetStatusLineStyle()

    function! SetStatusLineStyle()
        let &stl="%f %y "                       .
                    \"%([%R%M]%)"                   .
                    \"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
                    \"%{'$'[!&list]}"               .
                    \"%{'~'[&pm=='']}"              .
                    \"%="                           .
                    \"%#StatusLineNC#%{GitBranchInfoString()}%* " .
                    \"#%n %l/%L,%c%V "              .
                    \""
        "      \"%#StatusLineNC#%{GitBranchInfoString()}%* " .
    endfunc
    call SetStatusLineStyle()

    if has('title')
        set titlestring=%t%(\ [%R%M]%)
    endif

    "highlight StatusLine    ctermfg=White ctermbg=DarkBlue cterm=bold
    "highlight StatusLineNC  ctermfg=White ctermbg=DarkBlue cterm=NONE
endif


" ---------------------------------------------------------------------------
" setup for the visual environment
if has('gui_running')
    set bg=light
    set guioptions-=T
    set guioptions-=m
    set guioptions+=c
    "set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv
    "set guifont=Monospace\ 8,Terminal\ 8,fixed
    set guifont=ProggyCleanTT\ 12
else
    set bg=dark
endif

if $TERM =~ '^xterm'
    set t_Co=256 
elseif $TERM =~ '^screen-bce'
    set t_Co=256            " just guessing
elseif $TERM =~ '^rxvt'
    set t_Co=88
elseif $TERM =~ '^linux'
    set t_Co=8
else
    set t_Co=16
endif

"colorscheme desert              " 16 colour
"colorscheme ps_color
"colorscheme desert256           " 256 colour
"colorscheme gardener            " 256 colour
"colorscheme inkpot              " 256 colour
"colorscheme blacklight          " 256 colour

"let g:inkpot_black_background = 1
colorscheme solarized              " 256 colour
"colorscheme 256_asu1dark

" ---------------------------------------------------------------------------
" Folding for unified diffs 
" http://pastey.net/1483, mgedmin on #vim

function! DiffFoldLevel(lineno) 
    let line = getline(a:lineno) 
    if line =~ '^Index:' 
        return '>1' 
    elseif line =~ '^===' || line =~ '^RCS file: ' || line =~ '^retrieving revision '
        let lvl = foldlevel(a:lineno - 1) 
        return lvl >= 0 ? lvl : '=' 
    elseif line =~ '^diff' 
        return getline(a:lineno - 1) =~ '^retrieving revision ' ? '=' : '>1' 
    elseif line =~ '^--- ' && getline(a:lineno - 1) !~ '^diff\|^===' 
        return '>1' 
    elseif line =~ '^@' 
        return '>2' 
    elseif line =~ '^[- +\\]' 
        let lvl = foldlevel(a:lineno - 1) 
        return lvl >= 0 ? lvl : '=' 
    else 
        return '0' 
    endif 
endf 

function! FT_Diff() 
    if v:version >= 600 
        setlocal foldmethod=expr 
        setlocal foldexpr=DiffFoldLevel(v:lnum) 
    else 
    endif 
endf 

" ---------------------------------------------------------------------------
" no folds in vimdiff

function! NoFoldsInDiffMode()
    if &diff 
        :silent! :%foldopen! 
    endif
endf

augroup Diffs 
    autocmd! 
    autocmd BufRead,BufNewFile *.patch :setf diff 
    autocmd BufEnter           *       :call NoFoldsInDiffMode()
    autocmd FileType           diff    :call FT_Diff() 
augroup END

" ---------------------------------------------------------------------------
" tabs
map <LocalLeader>tc :tabnew %<cr>    " create a new tab       
map <LocalLeader>td :tabclose<cr>    " close a tab
map <LocalLeader>tn :tabnext<cr>     " next tab
map <LocalLeader>tp :tabprev<cr>     " previous tab
map <LocalLeader>tm :tabmove         " move a tab to a new location

" "dcraven" pasted "TabMessage: Put output of ex commands in a new tab." 
" (10 lines, 287B) at http://sial.org/pbot/20504

"TabMessage: Put output of ex commands in a new tab.
function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    tabnew
    silent put=message
    set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" ---------------------------------------------------------------------------
" auto load extensions for different file types
if has('autocmd')
    filetype plugin indent on
    syntax on

    " jump to last line edited in a given file (based on .viminfo)
    "autocmd BufReadPost *
    "       \ if !&diff && line("'\"") > 0 && line("'\"") <= line("$") |
    "       \       exe "normal g`\"" |
    "       \ endif
    autocmd BufReadPost *
                \ if line("'\"") > 0|
                \       if line("'\"") <= line("$")|
                \               exe("norm '\"")|
                \       else|
                \               exe "norm $"|
                \       endif|
                \ endif

    " improve legibility
    au BufRead quickfix setlocal nobuflisted wrap number

    " configure various extenssions
    let git_diff_spawn_mode=2

    " improved formatting for markdown
    " http://plasticboy.com/markdown-vim-mode/
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufRead ~/.blog/entries/*  set ai formatoptions=tcroqn2 comments=n:>
endif

" ---------------------------------------------------------------------------
"import other files...
":source ~/.vim/bk.vim      " does anyone actualy use bk anymore?

let $kernel_version=system('uname -r | tr -d "\n"')
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,/lib/modules/$kernel_version/build/tags,/usr/include/tags

helptags ~/.vim/doc

set dictionary=/usr/share/dict/words            " used with CTRL-X CTRL-K

" ---------------------------------------------------------------------------
"run the import script that looks for localized configuration changes
source ~/.vim/localized_vimrc.vim

" ---------------------------------------------------------------------------
"configure other scripts

" enable autoinstall of scripts w/o markup
" see :h :GLVS
let g:GetLatestVimScripts_allowautoinstall=1

" dynamic-explorer.vim (script 1890)
nmap <silent> <LocalLeader>f :FilesystemExplorer<CR>
nmap <silent> <LocalLeader>b :BufferExplorer<CR>

" ---------------------------------------------------------------------------
"this is for hg menu
if filereadable( "/usr/share/doc/mercurial/examples/hg-menu.vim" )
    let $backup_mapleader=mapleader
    let mapleader = ","
    source /usr/share/doc/mercurial/examples/hg-menu.vim
    let mapleader = $backup_mapleader
endif

" ===========================================================================
" ===========================================================================


" ---------------------------------------------------------------------------
"  configure calendar
let g:calendar_monday = 1
let g:backup_purge = 0
let g:backup_directory = "/home/kmcfate/.vim/backups"

" Folding
vmap <space> zf
nmap <space> zd
nmap <F2> 0v/{<CR>%zf
" This is an example vimrc that should work for testing purposes.
" Integrate the VimOrganizer specific sections into your own
" vimrc if you wish to use VimOrganizer on a regular basis. . .

"===================================================================
" THE NECESSARY STUFF"
" THe three lines below are necessary for VimOrganizer to work right
" =================================================================
filetype plugin indent on
" and then put these lines in vimrc somewhere after the line above
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

"==============================================================
" THE UNNECESSARY STUFF"
"=============================================================
"  Everything below here is a customization.  None are needed.
"============================================================

" vars below are used to define default Todo list and
" default Tag list.  Both of these can also be defined 
" on a document-specific basis by config lines in a file.
" See :h vimorg-todo-metadata and/or :h vimorg-tag-metadata
" 'TODO | DONE' is the default,so not really necessary to define it at all
let g:org_todo_setup='TODO | DONE'
" OR, e.g.,:
"let g:org_todo_setup='TODO NEXT STARTED | DONE CANCELED'

" include a tags setup string if you want:
let g:org_tags_alist='{small(s) medium(m) large(l) x-large(x)}'
"
" g:org_agenda_dirs specify directories that, along with 
" their subtrees, are searched for list of .org files when
" accessing EditAgendaFiles().  Specify your own here, otherwise
" default will be for g:org_agenda_dirs to hold single
" directory which is directory of the first .org file opened
" in current Vim instance:
" Below is line I use in my Windows install:
" NOTE:  case sensitive even on windows.
let g:org_agenda_select_dirs=["~/.org_files"]
let g:agenda_files = split(glob("~/.org_files/*.org"),"\n")

" ---------------------
" Emacs setup
" --------------------
" To use Emacs you will need to define the client.  On
" Linux/OSX this is typically simple, just:
let g:org_command_for_emacsclient = 'emacsclient'
"
"On Windows it is more complicated, and probably involves creating
" a 'soft link' to the emacsclient executable (which is 'emacsclientw')
" See :h vimorg-emacs-setup
"let g:org_command_for_emacsclient = 'c:\users\herbert\emacsclientw.exe'

" ---------------------
" Custom Agenda Searches
" --------------------
" the assignment to g:org_custom_searches below defines searches that a 
" a user can then easily access from the Org menu or the Agenda Dashboard.
" (Still need to add help on how to define them, assignment below
" is hopefully illustrative for now. . . . )
let g:org_custom_searches = [
            \  { 'name':"Next week's agenda", 'type':'agenda', 
            \              'agenda_date':'+1w','agenda_duration':'w'}
            \, { 'name':"Next week's TODOS", 'type':'agenda', 
            \    'agenda_date':'+1w','agenda_duration':'w','spec':'+UNFINISHED_TODOS'}
            \, { 'name':'Home tags', 'type':'heading_list', 'spec':'+HOME'}
            \, { 'name':'Home tags', 'type':'sparse_tree', 'spec':'+HOME'}
            \           ]

" --------------------------------
" Custom colors
" --------------------------------"
" OrgCustomColors() allows a user to set highlighting for particular items
function! OrgCustomColors()
    " various text item "highlightings" are below
    " these are the defaults.  Uncomment and change a line if you
    " want different highlighting for the element
    "
    " below are defaults for any TODOS you define.  TODOS that
    " come before the | in a definition will use  'NOTDONETODO'
    " and those that come after are DONETODO
    "hi! DONETODO guifg=green ctermfg=green
    "hi! NOTDONETODO guifg=red ctermfg=lightred

    " heading level highlighting is done in pairs, one for the
    " heading when unfoled and one for folded.  Default is to make
    " them the same except for the folded version being bold:
    " assign OL1 pair for level 1, OL2 pair for level 2, etc.
    "hi! OL1 guifg=somecolor guibg=somecolor 
    "hi! OL1Folded guifg=somecolor guibg=somecolor gui=bold


    " tags are lines below headings that have :colon:separated:tags:
    "hi! Org_Tag guifg=lightgreen ctermfg=blue

    "  lines that begin with '#+' in column 0 are config lines
    "hi! Org_Config_Line guifg=darkgray ctermfg=magenta

    "drawers are :PROPERTIES: and :LOGBOOK: lines and their associated
    " :END: lines
    "hi! Org_Drawer guifg=pink ctermfg=magenta
    "hi! Org_Drawer_Folded guifg=pink ctermfg=magenta gui=bold cterm=bold

    " this applies to value names in :PROPERTIES: blocks 
    "hi! Org_Property_Value guifg=pink ctermfg=magenta

    " three lines below apply to different kinds of blocks
    "hi! Org_Block guifg=#555555 ctermfg=magenta
    "hi! Org_Src_Block guifg=#555555 ctermfg=magenta
    "hi! Org_Table guifg=#888888 guibg=#333333 ctermfg=magenta

    " dates are date specs between angle brackets (<>) or square brackets ([])
    "hi! Org_Date guifg=magenta ctermfg=magenta gui=underline cterm=underline

    " Org_Star is used to "hide" initial asterisks in a heading
    "hi! Org_Star guifg=#444444 ctermfg=darkgray

    "hi! Props guifg=#ffa0a0 ctermfg=gray

    " bold, itals, underline, and code are highlights applied
    " to character formatting
    "hi! Org_Code guifg=darkgray gui=bold ctermfg=14
    "hi! Org_Itals gui=italic guifg=#aaaaaa ctermfg=lightgray
    "hi! Org_Bold gui=bold guifg=#aaaaaa ctermfg=lightgray
    "hi! Org_Underline gui=underline guifg=#aaaaaa ctermfg=lightgray
    "hi! Org_Lnumber guifg=#999999 ctermfg=gray

    " these lines apply to links: [[link]], and [[link][link desc]]
    "if has("conceal")
    "    hi! default linkends guifg=blue ctermfg=blue
    "endif
    "hi! Org_Full_Link guifg=cyan gui=underline ctermfg=lightblue cterm=underline
    "hi! Org_Half_Link guifg=cyan gui=underline ctermfg=lightblue cterm=underline

    "  applies to the Heading line that can be displayed in column view
    "highlight OrgColumnHeadings guibg=#444444 guifg=#aaaaaa gui=underline

    " Use g:org_todo_custom_highlights to set up highlighting for individual
    " TODO items.  Without this all todos that designate an uninished state 
    " will be highlighted using NOTDONETODO highlight (see above) 
    " and all todos that designate a finished state will be highlighted using
    " the DONETODO highlight (see above).
    let g:org_todo_custom_highlights = 
                \     { 'NEXT': { 'guifg':'#888888', 'guibg':'#222222',
                \              'ctermfg':'gray', 'ctermbg':'darkgray'},
                \      'WAITING': { 'guifg':'#aa3388', 
                \                 'ctermfg':'red' } }

endfunction

" below are two examples of Org-mode "hook" functions
" These present opportunities for end-user customization
" of how VimOrganizer works.  For more info see the 
" documentation for hooks in Emacs' Org-mode documentation:
" http://orgmode.org/worg/org-configs/org-hooks.php#sec-1_40
"
" These two hooks are currently the only ones enabled in 
" the VimOrganizer codebase, but they are easy to add so if
" there's a particular hook you want go ahead and request it
" or look for where these hooks are implemented in 
" /ftplugin/org.vim and use them as example for placing your
" own hooks in VimOrganizer:
function! Org_property_changed_functions(line,key, val)
    "call confirm("prop changed: ".a:line."--key:".a:key." val:".a:val)
endfunction
function! Org_after_todo_state_change_hook(line,state1, state2)
    "call confirm("changed: ".a:line."--key:".a:state1." val:".a:state2)
    "call OrgConfirmDrawer("LOGBOOK")
    "let str = ": - State: " . org#Pad(a:state2,10) . "   from: " . Pad(a:state1,10) .
    "            \ '    [' . org#Timestamp() . ']'
    "call append(line("."), repeat(' ',len(matchstr(getline(line(".")),'^\s*'))) . str)
endfunction

autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ -s4afpUcxjk3
autocmd BufNewFile,BufRead *.c set formatprg=astyle\ -s4afpUcxjk3
autocmd BufNewFile,BufRead *.h set formatprg=astyle\ -s4afpUcxjk3
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
set cursorline
set cursorcolumn

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

call pathogen#infect()
call pathogen#helptags()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_auto_loc_list=1
