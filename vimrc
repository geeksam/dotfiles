" ===== Plugins via vim-plug =====

    " Documentation on Plug:  https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    " Miscellaneous useful stuff

    Plug 'scrooloose/nerdtree'                          " file navigation
    Plug 'mhinz/vim-grepper'                            " one grep tool to rule them all?
    Plug 'jlanzarotta/bufexplorer'                      " Buffer Explorer, quite useful
    Plug 'godlygeek/tabular'                            " Tabularize:  vertical alignment goodness
    Plug 'tomtom/tcomment_vim'                          " Ctrl+dash 2x to comment (and a bunch of other stuff I never use)
    Plug 'flazz/vim-colorschemes'                       " loads o' colorschemes
    Plug 'tpope/vim-surround'                           " surrounding characters (ludicrously useful)
    Plug 'tpope/vim-repeat'                             " repeat plugin actions (e.g., from vim-surround)
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " dependency of fzf.vim
    Plug 'junegunn/fzf.vim'                             " use 'fzf' in vim (NOTE: `brew install fzf`)
    Plug 'danro/rename.vim'                             " Easy renames
    Plug 'wesQ3/vim-windowswap'                         " <Leader>ww in each of two windows to swap them
    Plug 'AndrewRadev/splitjoin.vim'                    " convert between one-line to multiline constructs
    Plug 'vim-scripts/ZoomWin'                          " 'C-w o' toggles between splits and a single pane
    Plug 'tpope/vim-fugitive'                           " Fugitive. You know, for Git!
    Plug 'Konfekt/FastFold'                             " hopefully, keep vim from slowing down when editing complex files...
    Plug 'manu-mannattil/vim-longlines'                 " Navigate long lines while word wrapping is on
    Plug 'vim-syntastic/syntastic'                      " multi-language syntax tools
    Plug 'simnalamburt/vim-mundo'                       " visualize the undo/redo tree for great power
    Plug 'nathanaelkane/vim-indent-guides'              " vertical indentation highlighting
    Plug 'jpalardy/spacehi.vim'                         " highlight spaces

    " TODO: look into 'sjl/gundo' for undo tree superpowers

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

    " golang (sighing intensifies)
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Add plugins to &runtimepath
    call plug#end()

" ===== Plugin config =====

set runtimepath+=/usr/local/opt/fzf
map <C-p> :FZF<CR>
let g:NERDTreeNodeDelimiter = "\u00a0" " Hide unsightly `^G` prefixes on filenames

" silence snipMate deprecation warning
let g:snipMate = { 'snippet_version' : 1 }

" stop syntastic from complaining about trailing ` ; nil` in stuff I intend to
" paste into Rails console
let g:syntastic_quiet_messages = {
  \ 'regex': 'useless use of nil in void context' }


let NERDTreeIgnore = ['\.pyc$']


" undo tree config
nnoremap <C-u> :MundoToggle<CR>
let g:mundo_preview_bottom = 1
let g:mundo_help = 1


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
set magic                          " make regular expressions behave sanely (i.e. "." matches any character vs. "\." )
set showmatch                      " Show matching bracets when text indicator is over them
set noerrorbells                   " No sound on errors
set novisualbell
set vb t_vb=                       " set the "visual bell" code to nothing
set nu                             " print line numbers in gutter
set numberwidth=4


" make hard tabs visible (I want to type "ducking" more often than I want tabs)
" ditto trailing whitespace
" this used to be some weird bullshit I didn't understand; now, spacehi.vim does it
nmap <leader><Space> :ToggleSpaceHi<cr>
augroup mostly_spacehi
  autocmd Syntax    *       SpaceHi
  autocmd FileType  help  NoSpaceHi
  autocmd FileType  diff  NoSpaceHi
  autocmd FileType  man   NoSpaceHi
  autocmd FileType  go    NoSpaceHi
  autocmd FileType  make  NoSpaceHi
augroup END

" vim-indent-guides:
" - disable by default
" - add a binding
" - color customizations are with the other color settings, below.
let g:indent_guides_enable_on_vim_startup=0
nmap <leader>i :IndentGuidesToggle<cr>

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

" Syntax highlighting can be slow on some large files.  Be more patient.
set redrawtime=5000

" quickfix list. WHO KNEW?!
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>x :cclose<CR>

" ===== Encoding and locale =====
set encoding=utf8

try
  lang en_US
catch
endtry

set ffs=unix,dos,mac " Default file types


" ===== Files and backups =====

" Turn backup off, since most stuff is in git anyway...
set nobackup
set nowb
set noswapfile


" ===== Text, tab and indent related =====

set expandtab
set shiftwidth=2
set tabstop=8
set softtabstop=2
set tw=80
set ai "Auto indent


" ===== Moving around, tabs and buffers =====

"Quickly open a scratch buffer
map <leader>q :enew<cr>

" Lazy way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Show buffer list (also mapped to "<leader>be", but this is easier to type
map <leader>bb :BufExplorer<cr>

" IDK why <CR> stopped working in my quickfix lists (Sep 2024), but this mapping does what I want
nmap <leader>o :.cc<CR>

" ===== Statusline =====

" Never hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
  let curdir = substitute(getcwd(), '/Users/sam/', "~/", "g")
  return curdir
endfunction


" ===== All files =====
autocmd FileType * :set colorcolumn=0 " Never bother me with concepts like 'right margins' ;P
autocmd FileType * :set expandtab     " No tabs ever, tyvm.  To fix: `:retab`
" autocmd FileType * :set fileformat=unix

" ===== Text files =====
autocmd FileType text setlocal textwidth=80
autocmd FileType text setlocal nosi
autocmd FileType text :set spl=en_us spell
autocmd FileType text :set fileformat=unix
autocmd FileType gitcommit setlocal textwidth=80
autocmd FileType gitcommit setlocal nosi
autocmd FileType gitcommit :set spl=en_us spell

" ===== HTML files =====
autocmd FileType html :set spl=en_us spell

" ===== Ruby files =====
autocmd BufNewFile,BufRead Gemfile* set syntax=ruby " support, e.g., `Gemfile-foo`
autocmd FileType ruby :set foldmethod=syntax
autocmd FileType ruby :set foldlevel=1
autocmd FileType ruby :set fileformat=unix
autocmd FileType ruby :set expandtab
autocmd FileType ruby :set tabstop=13
autocmd FileType ruby :set softtabstop=2
autocmd FileType ruby :set shiftwidth=2
autocmd FileType ruby :set autoindent

" ===== YAML files (hork) =====
autocmd FileType yaml :set foldmethod=indent
autocmd FileType yaml :set foldlevel=1

" ===== golang =====
" NB:  SpaceHi is managed in its own `augroup`
autocmd FileType go :set foldmethod=syntax
autocmd FileType go :set foldlevel=0
autocmd FileType go :set noexpandtab
autocmd FileType go :set tabstop=4
autocmd FileType go :set shiftwidth=4


" ====== Golang Settings (swiped from coworker) ========

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

"Use gopls for go autocompletion
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" nmap <leader>gb :GoBuild<CR>
" nmap <leader>gt :GoTest<CR>

" ==== Golang Settings END =====


" ===== Sam's Customizations =====

" using foldmethod=syntax can be very very slow, especially in Ruby.
" Solution: https://vim.fandom.com/wiki/Keep_folds_closed_while_inserting_text
" > Don't screw up folds when inserting text that might affect them, until
" > leaving insert mode. Foldmethod is local to the window. Protect against
" > screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm')         | let w:last_fdm=&foldmethod   | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm           | endif


" If I want spell checking, vim, I'll ask you for it.
autocmd FileType text :set nospell

" If I want help, vim, I'll :h you for it.
nmap <F1> :echo<CR>
imap <F1> <Esc>

" Split using similar keys to the ones I have in tmux
:noremap <leader>\| :vsp<cr> " Quick access to vertical splits
:noremap <leader>- :split<cr> " Quick access to horizontal splits

" disable mouse (it interferes with my terminal selections)
set mouse=

" line break without breaking words
set wrap
set linebreak
set nolist  " list disables linebreak


" ===== Colors =====
" IDK why, but these colors keep getting reset or something?  Vim is weird.
autocmd WinEnter * hi IndentGuidesOdd ctermbg=237
autocmd WinEnter * hi IndentGuidesEven ctermbg=236

set t_Co=256 " 256 colors
set background=dark
colorscheme herald

  " ===================================================================
  " ===== COLOR CHEAT SHEET: https://jonasjacek.github.io/colors/ =====
  " ===================================================================

  " I like the 'herald' color scheme, but some of its color combos are unreadable...
  if has("gui_running")
    hi Comment          guibg=#1F1F1F guifg=#909090 gui=none
    hi Folded           guibg=#001336 guifg=#005fff gui=none
    hi TabLine          guibg=#141414 guifg=#8A8A8A gui=none
    hi StatusLine       guibg=#0000d7 guifg=#bcbcbc gui=none
    hi StatusLineNC     guibg=#262626 guifg=#8a8a8a gui=none
    hi IndentGuidesOdd  guibg=#3a3a3a
    hi IndentGuidesEven guibg=#444444
  elseif &t_Co == 256
    hi ColorColumn      ctermbg=235  ctermfg=none  cterm=none
    hi Comment          ctermbg=234  ctermfg=248   cterm=none
    hi Folded           ctermbg=234  ctermfg=27    cterm=none
    hi TabLine          ctermbg=233  ctermfg=245   cterm=none
    hi StatusLine       ctermbg=20   ctermfg=250   cterm=none
    hi StatusLineNC     ctermbg=235  ctermfg=245   cterm=none
    hi IndentGuidesOdd  ctermbg=237  ctermfg=15    cterm=none
    hi IndentGuidesEven ctermbg=236  ctermfg=15    cterm=none
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
" ...the way spacemacs does it
nmap <Space>ff :e %:h<CR>
" send current filename to pbcopy (NB: `echo -n` omits trailing newline)
nmap <Leader>c. :!echo -n % \| pbcopy<CR>


" Fonts for MacVIM
if has("gui_running")
  set guioptions=-t
  set guifont=Monaco:h16
endif

" Reflow paragraph
nmap <Leader>r gqip
vmap <Leader>r gq

" Visual mode ops: sort, [sort+]uniq
vmap <Leader>so !sort<CR>
vmap <Leader>su !sort<Space>\|<Space>uniq<CR>

" SplitJoin
nmap <Leader>sl :SplitjoinSplit<CR>
nmap <Leader>jl :SplitjoinJoin<CR>

" Tabularize
nmap <Leader>ah :Tabularize/=><CR>
vmap <Leader>ah :Tabularize/=><CR>
" lolvim: the sequence "\@!" apparently means "zero of the thing I just said"
nmap <Leader>a= :Tabularize/:\?=\+>\@!<CR>
vmap <Leader>a= :Tabularize/:\?=\+>\@!<CR>

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
" * Per http://vimcasts.org/episodes/aligning-text-with-tabular-vim/, the \zs
"   atom excludes the [previous] character from the search match.  Similarly,
"   `\ze` should exclude the following char.
" * Per other resources,
"   * `\zs` marks the *s*tart of 'the passage to be operated on', and
"   * `\ze` marks the *e*nd of same
" * `\zs` is used here like a zero-width lookbehind assertion to
"   eat spaces before the comma/colon/whatever.
" * `\ze` can also be used here like a zero-width lookahead.
" * l0c1 is a format specifier that says
"   "left, then zero spaces, then [delimiter], then 1 space"
"   See: https://raw.github.com/godlygeek/tabular/master/doc/Tabular.txt
" TODO: this can probably be replaced with just \s, in at least some cases?
nmap <Leader>a# :Tabularize/ # /l0c0<CR>
vmap <Leader>a# :Tabularize/ # /l0c0<CR>
nmap <Leader>a: :Tabularize/:\zs /l0c0<CR>
vmap <Leader>a: :Tabularize/:\zs /l0c0<CR>
nmap <Leader>a, :Tabularize/, \zs/l0c1<CR>
vmap <Leader>a, :Tabularize/, \zs/l0c1<CR>
nmap <Leader>a\| :Tabularize/\s\|/l0c1<CR>
vmap <Leader>a\| :Tabularize/\s\|/l0c1<CR>
nmap <Leader>ato :Tabularize/).\(to\|to_not\|not_to\)\?<CR>:Tabularize/expect(<CR>:Tabularize/change<CR>
vmap <Leader>ato :Tabularize/).\(to\|to_not\|not_to\)\?<CR>:Tabularize/expect(<CR>:Tabularize/change<CR>
nmap <Leader>a( :Tabularize/(\zs/l0c1<CR>:Tabularize/)/l1c0<CR>
vmap <Leader>a( :Tabularize/(\zs/l0c1<CR>:Tabularize/)/l1c0<CR>
nmap <Leader>a[ :Tabularize/[\zs/l0c1<CR>:Tabularize/]/l1c0<CR>
vmap <Leader>a[ :Tabularize/[\zs/l0c1<CR>:Tabularize/]/l1c0<CR>
nmap <Leader>a{ :Tabularize/\s{/l0c1<CR>:Tabularize/}\s/l1c0<CR>
vmap <Leader>a{ :Tabularize/\s{/l0c1<CR>:Tabularize/}\s/l1c0<CR>


" Trailing whitespace sucks. (spacehi.vim makes it visible, or should...)
" Nuke it with F6:
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Vim doesn't always cope with display changes well; force full redraw
" Also, the command window seems to like to embiggen itself now (Jan 2023), so reset that shit too
nmap <Leader>t :redraw!<CR>:set cmdheight=2<CR>:set cmdheight=1<CR>


" NOTE:
"   `gv` re-selects the last visual selection;
"   this maps `gv` to re-select the last paste
"   source: https://vimtricks.com/p/reselect-pasted-text/
nnoremap gp `[v`]


" vim-grepper!
let g:grepper = {}

let g:grepper.dir = 'repo,cwd'
let g:grepper.tools = ['ag', 'rg']
let g:grepper.rg = {} " have to set this for the next line to work
let g:grepper.rg.grepprg = 'rg -H --no-heading --vimgrep --sort=path'

let g:grepper.prompt_quote = 0

let g:grepper.highlight    = 1
let g:grepper.quickfix     = 1 " using location list means ':.cc' doesn't work. why is vim like this. why.
let g:grepper.open         = 1 " do open the list (if there are results)
let g:grepper.switch       = 1 " do switch to the list after open
let g:grepper.jump         = 0 " BUT don't clobber existing buffers, tyvm

nnoremap <leader>g :Grepper -tool rg<CR>
nnoremap <leader>* :Grepper -tool rg -cword<CR>


