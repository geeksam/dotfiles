" Initially swiped from the .vimrc in ls-pair

" ===== Plugins via vim-plug =====

    " Documentation on Plug:  https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    # Miscellaneous useful stuff
    Plug 'scrooloose/nerdtree'          " file navigation
    Plug 'rking/ag.vim'                 " use the Silver Searcher in vim
    Plug 'jremmen/vim-ripgrep'          " use RipGrep in vim
    Plug 'jlanzarotta/bufexplorer'      " Buffer Explorer, quite useful
    Plug 'godlygeek/tabular'            " Tabularize:  vertical alignment goodness
    Plug 'tomtom/tcomment_vim'          " Ctrl+dash 2x to comment (and a bunch of other stuff I never use)
    Plug 'flazz/vim-colorschemes'       " loads o' colorschemes
    Plug 'tpope/vim-surround'           " surrounding characters (ludicrously useful)
    Plug 'tpope/vim-repeat'             " repeat plugin actions (e.g., from vim-surround)
    Plug 'junegunn/fzf.vim'             " use 'fzf' in vim (NOTE: `brew install fzf`)
    Plug 'danro/rename.vim'             " Easy renames
    Plug 'wesQ3/vim-windowswap'         " <Leader>ww in each of two windows to swap them
    Plug 'AndrewRadev/splitjoin.vim'    " convert between one-line to multiline constructs
    Plug 'vim-scripts/ZoomWin'          " 'C-w o' toggles between splits and a single pane
    Plug 'tpope/vim-fugitive'           " Fugitive. You know, for Git!
    Plug 'Konfekt/FastFold'             " hopefully, keep vim from slowing down when editing complex files...
    Plug 'manu-mannattil/vim-longlines' " Navigate long lines while word wrapping is on

    " TextMate-style snippets
    Plug 'garbas/vim-snipmate'
    Plug 'MarcWeber/vim-addon-mw-utils' " dependency of vim-snipmate
    Plug 'tomtom/tlib_vim'              " dependency of vim-snipmate
    filetype plugin on " apparently snipMate needs this
    Plug 'honza/vim-snippets'           " a bunch of premade snippets

    " This is a dependency of at least one other text object plugin
    Plug 'kana/vim-textobj-user'

    " Ruby, Ruby, Ruby!
    Plug 'tpope/vim-rails'                " pretty much what it says on the tin
    Plug 'tpope/vim-endwise'              " Automatically enter closing tokens (e.g., 'end' in Ruby)
    Plug 'vim-ruby/vim-ruby'              " Recent-ish Ruby syntax highlighting
    Plug 'nelstrom/vim-textobj-rubyblock' " spiffy nav inside/around Ruby blocks
    Plug 'kchmck/vim-coffee-script'       " pretty much what it says on the tin

    " Python, Python, Python!
    Plug 'psf/black'            " autoformatting
    Plug 'gryf/pylint-vim'      " linting
    Plug 'davidhalter/jedi-vim' " autocomplete (and probably some other stuff?)

    " Plugins I used to have:
    " - gundo
    " - vim-bundler
    " - vim-cucumber
    " - vim-markdown

    " Add plugins to &runtimepath
    call plug#end()

" ===== Plugin config =====

set rtp+=/usr/local/opt/fzf
map <C-p> :FZF<Enter>
let g:NERDTreeNodeDelimiter = "\u00a0" " Hide unsightly `^G` prefixes on filenames
let g:jedi#popup_on_dot = 0 " can still use C-<space> to open intellisense-like autocompletion

" ===== General =====

" Modelines: more trouble than they're worth
set nomodeline

" No reason to limit ourselves to vi compatibility
set nocompatible

" Enable extended % matching
runtime macros/matchit.vim

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Change <leader>, because commas are easier to reach for than backslashes
let mapleader = ","
let g:mapleader = ","

" " Basic setup for pathogen
" call pathogen#infect()
" syntax on
" filetype plugin indent on

" Remember command line entries
set history=300

" Reload files when they are changed by another process.
set autoread
" augroup checktime
"     au!
"     if !has("gui_running")
"         "silent! necessary otherwise throws errors when using command
"         "line window.
"         autocmd BufEnter        * silent! checktime
"         autocmd CursorHold      * silent! checktime
"         autocmd CursorHoldI     * silent! checktime
"         "these two _may_ slow things down. Remove if they do.
"         autocmd CursorMoved     * silent! checktime
"         autocmd CursorMovedI    * silent! checktime
"     endif
" augroup END
"
" " When editing a file, always jump to the last known cursor position.
" " Don't do it when the position is invalid or when inside an event handler
" " (happens when dropping a file on gvim).
" " Also don't do it when the mark is in the first line, that is the default
" " position when opening a file.
" autocmd BufReadPost *
"   \ if line("'\"") > 1 && line("'\"") <= line("$") |
"   \   exe "normal! g`\"" |
"   \ endif
"
" " Maintain some setup between sessions
" set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize



" ===== VIM UI =====

set scrolloff=7                    " n lines of context above and below the cursor
set sidescrolloff=10
set wildmenu                       " Turn on WiLd menu
set ruler                          " Always show current position
set cmdheight=1                    " The commandbar height
set hid                            " Change buffer without saving
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase                     " Ignore case when searching
set smartcase                      " Ignore case when searching lowercase
set hlsearch                       " highlight search
set incsearch                      " incremental search, search as you type
map <silent> <leader><cr> :noh<cr> " clear search highlighting
set magic                          " make regular expressions behave sanely (i.e.           " . " matches any character vs. " \. " )
set showmatch                      " Show matching bracets when text indicator is over them
set noerrorbells                   " No sound on errors
set novisualbell
set t_vb=
set nu                             " print line numbers in gutter
set numberwidth=4

" show trailing whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" open a new line without entering insert mode
map <Enter> o<ESC>

" sometimes the Escape key is too far away
" and in THE FUTURE, it might not even be a physical key. COURAGE
imap jj <Esc>

set showcmd " Defaults to on for vim anyway, but just in case
set nowrap
set linebreak " Wrap at word (display only; 'textwidth' affects physical insertion of EOL characters)

" Make dealing with split windows a little easier
set equalalways " Vertical and horizontal splits default to equal sizes when created
:noremap <leader>v :vsplit<cr>
:noremap <leader>h :split<cr>


" ===== Colors =====
set t_Co=256
set background=dark

" ===== Encoding and locale =====
set encoding=utf8

try
  lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

" ===== Files and backups =====

" Turn backup off, since most stuff is in git anyway...
set nobackup
set nowb
set noswapfile

" ===== Text, tab and indent related =====

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set tw=72
set ai "Auto indent
set si "Smart indet

" ===== Moving around, tabs and buffers =====

"Quickly open a scratch buffer
map <leader>q :enew<cr>

" Lazy way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" " Close the current buffer
" map <leader>bd :Bclose<cr>
"
" Show buffer list (also mapped to "<leader>be", but this is easier to type
map <leader>bb :BufExplorer<cr>

" Show NERDTree pane
map <leader>nn :NERDTree<cr>

" command! Bclose call <SID>BufcloseCloseIt()
" function! <SID>BufcloseCloseIt()
"   let l:currentBufNum = bufnr("%")
"   let l:alternateBufNum = bufnr("#")
"
"   if buflisted(l:alternateBufNum)
"     buffer #
"   else
"     bnext
"   endif
"
"   if bufnr("%") == l:currentBufNum
"     new
"   endif
"
"   if buflisted(l:currentBufNum)
"     execute("bdelete! ".l:currentBufNum)
"   endif
" endfunction
"
" " Specify the behavior when switching between buffers
" try
"   set switchbuf=usetab
"   set stal=1
" catch
" endtry
"
"
" ===== Statusline =====

" Never hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
  let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
  return curdir
endfunction


" ===== Text files =====

autocmd FileType text setlocal textwidth=72
autocmd FileType text setlocal nosi
autocmd FileType text :set spl=en_us spell
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal nosi
autocmd FileType gitcommit :set spl=en_us spell

" ===== HTML files =====
autocmd FileType html :set spl=en_us spell

" ===== Ruby files =====
compiler ruby         " Enable compiler support for ruby
autocmd FileType ruby :set foldmethod=syntax
autocmd FileType ruby :set foldlevel=1


" ===== Sam's Customizations =====

" If I want spell checking, vim, I'll ask you for it.
autocmd FileType text :set nospell

" If I want help, vim, I'll :h you for it.
nmap <F1> :echo<CR>
imap <F1> <Esc>

" Setting up CtrlP to use faster options!
if executable('rg') " ripgrep
  " let g:ackprg = 'rg --vimgrep'
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
elseif executable('ag') " The Silver Searcher
  " let g:ackprg = 'ag --vimgrep' " from https://github.com/ggreer/the_silver_searcher
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Split using similar keys to the ones I have in tmux
:noremap <leader>\| :vsp<cr> " Quick access to vertical splits
:noremap <leader>- :split<cr> " Quick access to horizontal splits

" disable mouse (it interferes with my terminal selections)
set mouse=

" line break without breaking words
set wrap
set linebreak
set nolist  " list disables linebreak

" Colors
set t_Co=256 " 256 colors
set background=dark
colorscheme herald

  " I like the 'herald' color scheme, but some of its color combos are unreadable...
  if has("gui_running")
    hi Comment        guibg=#1F1F1F guifg=#909090 gui=none
    hi Folded         guibg=#001336 guifg=#005fff gui=none
    hi TabLine        guibg=#141414 guifg=#8A8A8A gui=none
    hi StatusLine     guibg=#0000d7 guifg=#bcbcbc gui=none
    hi StatusLineNC   guibg=#262626 guifg=#8a8a8a gui=none
  elseif &t_Co == 256
    hi Comment        ctermbg=234  ctermfg=248   cterm=none
    hi Folded         ctermbg=234  ctermfg=27    cterm=none
    hi TabLine        ctermbg=233  ctermfg=245   cterm=none
    hi StatusLine     ctermbg=20   ctermfg=250   cterm=none
    hi StatusLineNC   ctermbg=235  ctermfg=245   cterm=none
  elseif &t_Co == 16
    hi Comment        ctermbg=8 ctermfg=7 cterm=none
  elseif &t_Co == 8
    hi Comment        ctermbg=8 ctermfg=7 cterm=none
  endif

  " Also, make the background a shade darker (terminal only)
  if &t_Co == 256
    hi Normal                  ctermbg=233

    hi Comment                 ctermbg=233
    hi Constant                ctermbg=233
    hi Delimiter               ctermbg=233
    hi DiffDelete              ctermbg=233
    hi Error                   ctermbg=233
    hi Exception               ctermbg=233
    hi Folded                  ctermbg=233
    hi FoldColumn              ctermbg=233
    hi Function                ctermbg=233
    hi Identifier              ctermbg=233
    hi Ignore                  ctermbg=233
    hi NonText                 ctermbg=233
    hi Operator                ctermbg=233
    hi PreProc                 ctermbg=233
    hi Special                 ctermbg=233
    hi SpecialKey              ctermbg=233
    hi Statement               ctermbg=233
    hi String                  ctermbg=233
    hi Todo                    ctermbg=233
    hi Type                    ctermbg=233
    hi Underlined              ctermbg=233
    hi VertSplit               ctermbg=233
    hi htmlBold                ctermbg=233
    hi htmlBoldItalic          ctermbg=233
    hi htmlBoldUnderline       ctermbg=233
    hi htmlBoldUnderlineItalic ctermbg=233
    hi htmlItalic              ctermbg=233
    hi htmlUnderline           ctermbg=233
    hi htmlUnderlineItalic     ctermbg=233
  endif


" Quickly toggle wordwrap
:noremap <leader>W :set wrap<cr>
:noremap <leader>w :set nowrap<cr>
set nowrap
set linebreak " Wrap at characters in `breakat`
              " (display-only setting; `textwidth` affects physical insertion of EOL characters)

" Quickly toggle linebreak
:noremap <leader>L :set textwidth=80<cr>
:noremap <leader>l :set textwidth=0<cr>
set textwidth=0 " Default to 'stop \'helping\' me, vim'

" Edit the current directory
nmap <Leader>e. :e %:h<CR>

" Fonts for MacVIM
if has("gui_running")
  set guioptions=-t
  set guifont=Monaco:h16
endif

" Reflow paragraph
nmap <Leader>r gqip
vmap <Leader>r gq

" SplitJoin
nmap <Leader>sl :SplitjoinSplit<CR>
nmap <Leader>jl :SplitjoinJoin<CR>

" Indent Guides
let g:indent_guides_auto_colors = 0
if has("gui_running") || &t_Co == 256
  hi IndentGuidesOdd  ctermbg=234
  hi IndentGuidesEven ctermbg=235
endif
autocmd FileType text :IndentGuidesEnable

" Tabularize
nmap <Leader>a# :Tabularize/#<CR>
vmap <Leader>a# :Tabularize/#<CR>
nmap <Leader>ah :Tabularize/=><CR>
vmap <Leader>ah :Tabularize/=><CR>
" lolvim: the sequence "\@!" apparently means "zero of the thing I just said"
nmap <Leader>a= :Tabularize/=\+>\@!<CR>
vmap <Leader>a= :Tabularize/=\+>\@!<CR>

nmap <Leader>a; :Tabularize/;<CR>
vmap <Leader>a; :Tabularize/;<CR>
nmap <Leader>a{ :Tabularize/{<CR>:Tabularize/}<CR>
vmap <Leader>a{ :Tabularize/{<CR>:Tabularize/}<CR>

" Elixir!
nmap <Leader>ado :Tabularize/do:<CR>
vmap <Leader>ado :Tabularize/do:<CR>
nmap <Leader>awh :Tabularize/when<CR>
vmap <Leader>awh :Tabularize/when<CR>


" NOTES:
" * \zs is basically a zero-width lookbehind assertion;
"   it eats spaces before the comma/colon/whatever.
"   See: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" * l0c1 is a format specifier that says
"   "left, then zero spaces, then [delimiter], then 1 space"
"   See: https://raw.github.com/godlygeek/tabular/master/doc/Tabular.txt
nmap <Leader>a: :Tabularize/:\zs /l0c0<CR>
vmap <Leader>a: :Tabularize/:\zs /l0c0<CR>
nmap <Leader>a, :Tabularize/,\zs/l0c1<CR>
vmap <Leader>a, :Tabularize/,\zs/l0c1<CR>
nmap <Leader>ato :Tabularize/).to\(_not\)\?<CR>:Tabularize/expect(<CR>
vmap <Leader>ato :Tabularize/).to\(_not\)\?<CR>:Tabularize/expect(<CR>
nmap <Leader>a( :Tabularize/(\zs/l0c1<CR>:Tabularize/)/l1c0<CR>
vmap <Leader>a( :Tabularize/(\zs/l0c1<CR>:Tabularize/)/l1c0<CR>
nmap <Leader>a[ :Tabularize/[\zs/l0c1<CR>:Tabularize/]/l1c0<CR>
vmap <Leader>a[ :Tabularize/[\zs/l0c1<CR>:Tabularize/]/l1c0<CR>

" Trailing whitespace sucks.
"" Show it:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"" Nuke it with F6:
:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


