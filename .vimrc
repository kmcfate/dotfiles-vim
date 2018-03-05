set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

" snippets
"Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" syntax checking
Plugin 'scrooloose/syntastic'

" auto-configures itself pretty well
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" auto-align stuff
Plugin 'godlygeek/tabular'

" IDE stuff
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'vim-scripts/a.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'ervandew/supertab'
"Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
"Plugin 'chrisbra/changesPlugin'
"Plugin 'SirVer/ultisnips'


" for git
"Plugin 'tpope/vim-fugitive'

"Plugin 'tpope/vim-markdown'
"Plugin 'tomtom/tcomment_vim'


"Plugin 'Valloric/YouCompleteMe'

"Plugin 'mileszs/ack.vim'
"Plugin 'rking/ag.vim'

"Plugin 'astashov/vim-ruby-debugger'
"Plugin 'bling/vim-airline'
"Plugin 'pangloss/vim-javascript'
"Plugin 'Rip-Rip/clang_complete'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'timcharper/textile.vim'
"Plugin 'tpope/vim-cucumber'
"Plugin 'tpope/vim-git'
"Plugin 'tpope/vim-haml'
"Plugin 'tpope/vim-rails'
"Plugin 'tpope/vim-repeat'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-vividchalk'
"Plugin 'tmhedberg/matchit'
"Plugin 'tsaleh/vim-shoulda'
"Plugin 'Townk/vim-autoclose'
"Plugin 'tsaleh/vim-tmux'
"Plugin 'vim-ruby/vim-ruby'

" for the puppets
Plugin 'rodjek/vim-puppet'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ---------------------------------------------------------------------------
syntax on
filetype on
set backupdir=~/.vim/backups
set directory=~/.vim/tmp
let g:backup_directory = "/home/zl/kmcfate/.vim/backups"
" status
set laststatus=2
" colors
set bg=dark
set t_Co=256
colorscheme solarized
let g:airline_powerline_fonts = 1
" crosshairs
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
set cursorline
set cursorcolumn
" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" ycm
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" maps
nmap <F8> :TagbarToggle<CR>
map <F2> :Tab /=><CR>
" tabs
" Do not enable this, breaks autoindent some how
set autoindent smartindent      " turn on auto/smart indenting
set expandtab                   " use spaces, not tabs
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=4                   " tabstops of 8
set softtabstop=4              " tabstops of 8
set shiftwidth=4                " indents of 8
set listchars=tab:>-,trail:.,extends:>
set list
