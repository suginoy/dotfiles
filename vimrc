set nocompatible

" 文字コード, 改行コード {{{
set encoding=utf-8
set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
set fileformats=unix,dos,mac

" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = s:fileencodings_default .','. &fileencodings
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" }}}

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" NeoBundle {{{
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/skkdict.vim'

" colorschemes
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'baskerville/bubblegum'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'

NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/nerdcommenter'

NeoBundle 'thinca/vim-ref'
NeoBundle 'taka84u9/vim-ref-ri'
NeoBundle 'ujihisa/ref-hoogle'

NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'vim-scripts/L9'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'vim-scripts/errormarker.vim'
NeoBundle 'vim-scripts/AnsiEsc.vim'

NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-niceblock'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'carlosvillu/coffeScript-VIM-Snippets'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'tpope/vim-haml'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'juvenn/mustache.vim'

NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kana/vim-submode'
NeoBundle 'osyo-manga/vim-milfeulle'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'mattn/webapi-vim'

NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'dag/vim2hs'
NeoBundle 'pbrisbin/html-template-syntax'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'yonchu/accelerated-smooth-scroll'
NeoBundle 'LeafCage/foldCC'

NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'godlygeek/tabular'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'rking/ag.vim'
NeoBundle 'moro/vim-review'
NeoBundle 'bling/vim-airline'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'mattn/favstar-vim'
NeoBundleLazy 'basyura/twibill.vim'
NeoBundleLazy 'basyura/TweetVim', 'dev', {
\   'depends' : ['basyura/twibill.vim', 'tyru/open-browser.vim' ],
\   'autoload' : {
\       'commands' : [ "TweetVimHomeTimeline", "TweetVimSay", "TweetVimUserStream", "TweetVimUserTimeline" ]
\   }
\}

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'tsukkee/unite-help'
NeoBundle 'ujihisa/unite-gem'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'rhysd/unite-ruby-require.vim'

NeoBundleLazy 'Shougo/unite.vim', {
\   'autoload' : {
\       'commands' : [ "Unite", "UniteWithBufferDir", "UniteWithCurrentDir" ]
\   }
\}

NeoBundleLazy 'Shougo/neosnippet'
NeoBundle 'Rip-Rip/clang_complete'

if has('lua')
  NeoBundleLazy 'Shougo/neocomplete', {
  \   'depends' : ['Shougo/neosnippet', 'Shougo/context_filetype.vim'],
  \   'vim_version' : '7.3.885',
  \   'autoload' : {
  \       'insert' : 1,
  \   }
  \}
else
  NeoBundleLazy 'Shougo/neocomplcache', {
  \   'depends' : ["Shougo/neosnippet"],
  \   'autoload' : {
  \       'insert' : 1,
  \   }
  \}
endif

NeoBundleLazy 'Shougo/vimfiler', {
\   'depends' : ["Shougo/unite.vim"],
\   'autoload' : {
\       'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
\       'mappings' : ['<Plug>(vimfiler_switch)'],
\       'explorer' : 1,
\   }
\}

NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc',
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_switch)']
      \ }}

NeoBundleLazy 'mattn/gist-vim', {
\   'autoload' : {
\       'commands' : [ "Gist" ]
\   }
\}

NeoBundleLazy 'sjl/gundo.vim', {
\   'autoload' : {
\       'commands' : [ "GundoShow", "GundoToggle" ]
\   }
\}

NeoBundleLazy 'kana/vim-altr', {
\   'autoload' : {
\       'mappings' : ['<Plug>(altr-forward)', '<Plug>(altr-back)'],
\   }
\}

NeoBundle 'joker1007/vim-ruby-heredoc-syntax'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
" }}}


syntax enable
filetype plugin indent on

NeoBundleCheck

if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

" augroup init (from tyru's vimrc)
augroup vimrc
  autocmd!
augroup END

command!
\ -bang -nargs=*
\ MyAutocmd
\ autocmd<bang> vimrc <args>

" Basic Setting {{{
set bs=indent,eol,start     " allow backspacing over everything in insert mode
set ai                      " always set autoindenting on
set nobackup
set noswapfile              " No Swap
set viminfo=%,'100,<500,h
set history=100             " keep 100 lines of command line history
set ruler                   " show the cursor position all the time
set nu                      " show line number
set ambiwidth=double
set display=uhex            " 表示できない文字を16進数で表示
set scrolloff=5             " 常にカーソル位置から5行余裕を取る
set virtualedit=block       " 矩形選択でカーソル位置の制限を解除
set autoread                " 他でファイルが編集された時に自動で読み込む
set background=dark

" Space prefix
nnoremap [space] <Nop>
nmap     <Space> [space]
xmap     <Space> [space]

" Edit vimrc
nmap [space]v :edit $MYVIMRC<CR>
nmap [space]g :edit $MYGVIMRC<CR>

nnoremap <C-H> :<C-U>help<Space>

" 編集中の行に下線を引く
MyAutocmd InsertLeave * setlocal nocursorline
MyAutocmd InsertEnter * setlocal cursorline
MyAutocmd InsertLeave * highlight StatusLine ctermfg=145 guifg=#c2bfa5 guibg=#000000
MyAutocmd InsertEnter * highlight StatusLine ctermfg=12 guifg=#1E90FF


" タブストップ設定
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

" 折り畳み設定
set foldmethod=marker
nmap <silent> ,fc :<C-U>%foldclose<CR>
nmap <silent> ,fo :<C-U>%foldopen<CR>
set foldtext=FoldCCtext()

" 検索設定
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
nohlsearch "reset highlight
nnoremap <silent> [space]/ :noh<CR>
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

" ステータスライン表示
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%{tagbar#currenttag('[%s]','')}%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%{exists('*SkkGetModeStr')?SkkGetModeStr():''}%=%l/%L,%c%V%8P\
set noshowmode
set wildmenu
set cmdheight=2
set wildmode=list:full
set showcmd

" tabline
set showtabline=2
nnoremap <silent> <S-Right> :<C-U>tabnext<CR>
nnoremap <silent> <S-Left> :<C-U>tabprevious<CR>
nnoremap L :<C-U>tabnext<CR>
nnoremap H :<C-U>tabprevious<CR>

" completion
set complete=.,w,b,u,t,i,d,k

" クリップボード設定
set clipboard=unnamed

" バッファ切り替え
set hidden

" Tab表示
set list
set listchars=tab:>-,trail:<

" タイトルを表示
set title

" 対応括弧を表示
set showmatch

" 自動折り返しを日本語に対応させるスクリプト用の設定
set formatoptions+=mM

" matchitスクリプトの読み込み
source $VIMRUNTIME/macros/matchit.vim

" jkを直感的に
nnoremap <silent> j gj
nnoremap <silent> gj j
nnoremap <silent> k gk
nnoremap <silent> gk k
nnoremap <silent> $ g$
nnoremap <silent> g$ $
vnoremap <silent> j gj
vnoremap <silent> gj j
vnoremap <silent> k gk
vnoremap <silent> gk k
vnoremap <silent> $ g$
vnoremap <silent> g$ $

" JとDで半ページ移動
nnoremap J <C-D>
nnoremap K <C-U>

" <Space>h or <Space>lで行頭か行末に移動する
noremap [space]h  ^
noremap [space]l  $

" 編集中のファイルのディレクトリに移動
nnoremap ,d :execute ":lcd" . expand("%:p:h")<CR>

" 最後に編集した場所にカーソルを移動する
MyAutocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" colorscheme
" 全角スペースをハイライト
MyAutocmd ColorScheme * highlight ZenkakuSpace ctermbg=239 guibg=#405060
MyAutocmd VimEnter,WinEnter * call matchadd('ZenkakuSpace', '　')

if stridx($TERM, "xterm-256color") >= 0
  let g:solarized_termcolors= 256
  let g:solarized_contrast = "high"
  let g:solarized_termtrans = 1
  colorscheme solarized
else
  colorscheme desert
endif

" 256色モード
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif

" mark, register確認
" nnoremap ,m  :<C-u>marks<CR>
nnoremap ,r  :<C-u>registers<CR>
"---------------------------------------------------------}}}

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"

" surround.vim {{{
nmap ,( csw(
nmap ,) csw)
nmap ,{ csw{
nmap ,} csw}
nmap ,[ csw[
nmap ,] csw]
nmap ,' csw'
nmap ," csw"
"}}}

" Insert Mode Mapping {{{
inoremap <C-K> <ESC>"*pa
imap <C-E> <END>
imap <C-A> <HOME>

" }}}

" from http://vim-users.jp/2011/04/hack214/ {{{
vnoremap ( t(
vnoremap ) t)
vnoremap ] t]
vnoremap [ t[
onoremap ( t(
onoremap ) t)
onoremap ] t]
onoremap [ t[
" }}}

" set paste
nnoremap <silent> ,p :<C-U>set paste!<CR>:<C-U>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>

" eskk {{{
let g:eskk#large_dictionary = {
      \ 'path': $HOME . "/.vim/dict/skk/SKK-JISYO.L",
      \ 'sorted': 1,
      \ 'encoding': 'euc-jp',
      \}
" }}}

" wq alias
command! -nargs=0 Wq wq

" UTF8、SJIS(CP932)、EUCJPで開き直す {{{
command! -bang -nargs=? Utf8
\ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis
\ edit<bang> ++enc=cp932 <args>
command! -bang -nargs=? Euc
\ edit<bang> ++enc=eucjp <args>
" }}}

" YAMLファイル用タブストップ設定
au FileType yaml setlocal expandtab ts=2 sw=2 fenc=utf-8

" actionscript mxml用のファイルタイプ設定
MyAutocmd BufNewFile,BufRead *.as set filetype=actionscript
MyAutocmd BufNewFile,BufRead *.mxml set filetype=mxml

" バッファ切り替え {{{
nmap [space]n :<C-U>bnext<CR>
nmap [space]p :<C-U>bprevious<CR>
nnoremap <Leader>1   :e #1<CR>
nnoremap <Leader>2   :e #2<CR>
nnoremap <Leader>3   :e #3<CR>
nnoremap <Leader>4   :e #4<CR>
nnoremap <Leader>5   :e #5<CR>
nnoremap <Leader>6   :e #6<CR>
nnoremap <Leader>7   :e #7<CR>
nnoremap <Leader>8   :e #8<CR>
nnoremap <Leader>9   :e #9<CR>
" バッファ一覧
nmap ,b :buffers<CR>
" }}}

" NERDCommenter
let NERDSpaceDelims = 1

" smartchr {{{
function! s:EnableSmartchrBasic()
  inoremap <buffer><expr> + smartchr#one_of(' + ', '+', '++')
  inoremap <buffer><expr> & smartchr#one_of(' & ', ' && ', '&')
  inoremap <buffer><expr> , smartchr#one_of(', ', ',')
  inoremap <buffer><expr> <Bar> smartchr#one_of('<Bar>', ' <Bar><Bar> ', '<Bar><Bar>')
  inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= ' : search('\(\*\<bar>!\)\%#')? '= ' : smartchr#one_of(' = ', ' == ', '=')
endfunction

function! s:EnableSmartchrRegExp()
  inoremap <buffer><expr> ~ search('\(!\<bar>=\) \%#', 'bcn')? '<bs>~ ' : '~'
endfunction

function! s:EnableSmartchrRubyHash()
  inoremap <buffer><expr> > smartchr#one_of('>', ' => ')
endfunction

function! s:EnableSmartchrHaml()
  call s:EnableSmartchrRubyHash()
  inoremap <buffer> [ []<Esc>i
  inoremap <buffer> { {}<Esc>i
endfunction

function! s:EnableSmartchrCoffeeFunction()
  inoremap <buffer><expr> > smartchr#one_of('>', ' ->')
endfunction

MyAutocmd FileType c,cpp,php,python,javascript,ruby,coffee,vim call s:EnableSmartchrBasic()
MyAutocmd FileType python,ruby,coffee,vim call s:EnableSmartchrRegExp()
MyAutocmd FileType ruby call s:EnableSmartchrRubyHash()
MyAutocmd FileType ruby,eruby setlocal tags+=~/rtags
MyAutocmd FileType haml call s:EnableSmartchrHaml()
MyAutocmd FileType coffee call s:EnableSmartchrCoffeeFunction()
" }}}

" hatena.vim
let g:hatena_user = 'joker1007'

" shファイルの保存時にはファイルのパーミッションを755にする {{{
function! s:ChangeShellScriptPermission()
  if !has("win32")
    if &ft =~ "\\(z\\|c\\|ba\\)\\?sh$" && expand('%:t') !~ "\\(zshrc\\|zshenv\\)$"
      call system("chmod 755 " . shellescape(expand('%:p')))
      echo "Set permission 755"
    endif
  endif
endfunction
MyAutocmd BufWritePost * call s:ChangeShellScriptPermission()
" }}}

" QFixHowm用設定======================================================{{{
set runtimepath+=~/qfixapp

" ファイル拡張子をmkdにする
let howm_filename = '%Y-%m-%d-%H%M%S.mkd'
" ファイルタイプをmarkdownにする
let QFixHowm_FileType = 'markdown'
" 折り畳み正規表現
let QFixHowm_FoldingPattern = '^[=.*#]'

" タイトル記号
let QFixHowm_Title = '#'

"キーマップリーダー
let QFixHowm_Key = 'g'

"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir          = '~/Dropbox/howm'
let howm_fileencoding = 'utf-8'
let howm_fileformat   = 'unix'

if has('win32')
  let mygrepprg = 'yagrep'
elseif has('unix')
  let mygrepprg = 'grep'
endif

let QFixHowm_MruFileMax = 30

let QFixHowm_RecentMode = 2

" リネーム後のファイル名制限
let QFixHowm_FilenameLen = 80


"ブラウザの指定
if has('win32')
  let QFixHowm_OpenURIcmd = '!start "C:\firefox\firefox.exe" %s'
elseif has('mac')
  let QFixHowm_OpenURIcmd = "call system('/usr/bin/open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin %s')"
elseif has('unix')
  let QFixHowm_OpenURIcmd = "call system('xdg-open %s')"
endif
" }}}


" ポップアップメニューのカラーを設定
MyAutocmd Syntax * hi Pmenu ctermfg=15 ctermbg=18 guibg=#666666
MyAutocmd Syntax * hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
MyAutocmd Syntax * hi PmenuSbar guibg=#333333

" TOhtml
let g:html_number_lines = 0
let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = 'utf-8'

" grep.vim
let Grep_Default_Options = '-i'
nnoremap <C-G><C-G> :<C-u>GrepBuffer<Space>
nnoremap <C-G><C-W> :<C-u>GrepBuffer<Space><C-r>= expand('<cword>')<CR>

" quickrun{{{

" エスケープカラーを表示する。
MyAutocmd FileType quickrun AnsiEsc
" ヤンクを取りやすいようにconcealcursorを無効にする。
MyAutocmd FileType quickrun setlocal concealcursor=""

vnoremap <leader>q :QuickRun >>buffer -mode v<CR>
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': 'bundle exec %c %o --color --tty %s'
  \}
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': '%c %o --color --tty %s'
  \}
let g:quickrun_config['rspec/zeus'] = {
  \ 'type': 'rspec/zeus',
  \ 'command': 'rspec',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': 'zeus test %o --color --tty %s'
  \}
let g:quickrun_config['rspec/spring'] = {
  \ 'type': 'rspec/spring',
  \ 'command': 'rspec',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': 'spring rspec %o --color --tty %s'
  \}
let g:quickrun_config['cucumber/bundle'] = {
  \ 'type': 'cucumber/zeus',
  \ 'command': 'cucumber',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': 'bundle exec %c %o --color %s'
  \}
let g:quickrun_config['cucumber/zeus'] = {
  \ 'type': 'cucumber/zeus',
  \ 'command': 'cucumber',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': 'zeus cucumber %o --color %s'
  \}
let g:quickrun_config['cucumber/spring'] = {
  \ 'type': 'cucumber/spring',
  \ 'command': 'cucumber',
  \ 'outputter/buffer/split': 'botright',
  \ 'exec': 'spring cucumber %o --color %s'
  \}

function! s:RSpecQuickrun()
  if exists('g:use_spring_rspec') && g:use_spring_rspec == 1
    let b:quickrun_config = {'type' : 'rspec/spring'}
  elseif exists('g:use_zeus_rspec') && g:use_zeus_rspec == 1
    let b:quickrun_config = {'type' : 'rspec/zeus'}
  else
    let b:quickrun_config = {'type' : 'rspec/bundle'}
  endif

  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l " . line(".") . "\"<CR>"
endfunction
MyAutocmd BufReadPost *_spec.rb call s:RSpecQuickrun()

function! s:CucumberQuickrun()
  if exists('g:use_spring_cucumber') && g:use_spring_cucumber == 1
    let b:quickrun_config = {'type' : 'cucumber/spring'}
  elseif exists('g:use_zeus_cucumber') && g:use_zeus_cucumber == 1
    let b:quickrun_config = {'type' : 'cucumber/zeus'}
  else
    let b:quickrun_config = {'type' : 'cucumber/bundle'}
  endif

  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l " . line(".") . "\"<CR>"
endfunction
MyAutocmd BufReadPost *.feature call s:CucumberQuickrun()

function! s:SetUseSpring()
  let g:use_spring_rspec = 1
  let g:use_zeus_rspec = 0
  let g:use_spring_cucumber = 1
  let g:use_zeus_cucumber = 0
endfunction

function! s:SetUseZeus()
  let g:use_zeus_rspec = 1
  let g:use_spring_rspec = 0
  let g:use_zeus_cucumber = 1
  let g:use_spring_cucumber = 0
endfunction

function! s:SetUseBundle()
  let g:use_zeus_rspec = 0
  let g:use_spring_rspec = 0
  let g:use_zeus_cucumber = 0
  let g:use_spring_cucumber = 0
endfunction

command! -nargs=0 UseSpringRSpec let b:quickrun_config = {'type' : 'rspec/spring'} | call s:SetUseSpring()
command! -nargs=0 UseZeusRSpec   let b:quickrun_config = {'type' : 'rspec/zeus'}   | call s:SetUseZeus()
command! -nargs=0 UseBundleRSpec let b:quickrun_config = {'type' : 'rspec/bundle'} | call s:SetUseBundle()
command! -nargs=0 UseSpringCucumber let b:quickrun_config = {'type' : 'cucumber/spring'} | call s:SetUseSpring()
command! -nargs=0 UseZeusCucumber   let b:quickrun_config = {'type' : 'cucumber/zeus'}   | call s:SetUseZeus()
command! -nargs=0 UseBundleCucumber let b:quickrun_config = {'type' : 'cucumber/bundle'} | call s:SetUseBundle()
" }}}

" libruby load
if has('gui_macvim') && has('kaoriya')
  let s:ruby_libdir = system("ruby -rrbconfig -e 'print RbConfig::CONFIG[\"libdir\"]'")
  let s:ruby_libruby = s:ruby_libdir . '/libruby.dylib'
  if filereadable(s:ruby_libruby)
    let $RUBY_DLL = s:ruby_libruby
  endif
endif

" vim-milfeulle
nmap <C-O> <Plug>(milfeulle-prev)
nmap <C-I> <Plug>(milfeulle-next)


" Unite.vim {{{
nnoremap [unite] <Nop>
nmap     ,u [unite]
nnoremap <silent> [unite]ff   :<C-u>Unite -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]fr   :<C-u>Unite -buffer-name=files file_mru<CR>
nnoremap <silent> [unite]fa   :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> [unite]d   :<C-u>Unite -buffer-name=files directory_mru<CR>
nnoremap <silent> [unite]vff  :<C-u>Unite -vertical -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]vfr  :<C-u>Unite -vertical -buffer-name=files file_mru <CR>
nnoremap <silent> [unite]vp  :<C-u>Unite -vertical -winwidth=45 -no-quit -buffer-name=files buffer file<CR>
nnoremap <silent> [unite]F   :<C-u>UniteWithBufferDir -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]vF  :<C-u>UniteWithBufferDir -vertical -winwidth=45 -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]b   :<C-u>Unite -buffer-name=buffers -prompt=Buffer>\  buffer<CR>
nnoremap <silent> [unite]vb  :<C-u>Unite -vertical -buffer-name=buffers -prompt=Buffer>\  buffer<CR>
nnoremap <silent> [unite]vB  :<C-u>Unite -vertical -buffer-name=buffers -prompt=Buffer>\  -winwidth=45 -no-quit buffer<CR>
nnoremap <silent> [unite]o   :<C-u>Unite -vertical -winwidth=45 -wrap -no-quit -toggle -buffer-name=outline outline<CR>
nnoremap <silent> [unite]"   :<C-u>Unite -buffer-name=register -prompt=">\  register<CR>
nnoremap <silent> [unite]c   :<C-u>Unite -buffer-name=commands history/command<CR>
nnoremap <silent> [unite]C   :<C-u>Unite -buffer-name=commands command<CR>
nnoremap <silent> [unite]s   :<C-u>Unite -buffer-name=snippets snippet<CR>
nnoremap <silent> [unite]u   :<C-u>Unite source<CR>
nnoremap <silent> [unite]l   :<C-u>Unite -buffer-name=lines line<CR>
nnoremap <silent> [unite]m   :<C-u>Unite -buffer-name=bookmark -prompt=bookmark> bookmark<CR>
nnoremap <silent> [unite]rm   :<C-u>Unite -buffer-name=ref -prompt=ref> ref/man<CR>
nnoremap <silent> [unite]g   :<C-u>Unite -buffer-name=grep grep<CR>
nnoremap <silent> [unite]hd   :<C-u>Unite haddock -start-insert<CR>

let s:bundle = neobundle#get("unite.vim")
function! s:bundle.hooks.on_source(bundle)
  let g:unite_enable_start_insert = 1

  let g:unite_winheight = 15
  let g:unite_winwidth = 45
  let g:unite_source_grep_max_candidates = 500

  " unite-ruby-require
  let g:unite_source_ruby_require_ruby_command = expand("~/.rbenv/shims/ruby")

  " ディレクトリに対するブックマークはvimfilerをデフォルトアクションにする
  call unite#custom_default_action('source/bookmark/directory', 'vimfiler')

  call unite#custom#source('buffer,file,file_mru', 'sorters', 'sorter_rank')

  call unite#custom#source('file_rec,file_rec/async', 'filters',
        \ ['converter_relative_word', 'matcher_default',
        \  'sorter_rank', 'converter_relative_abbr', 'converter_file_directory'])

  call unite#custom#source(
        \ 'file_mru', 'converters',
        \ ['converter_file_directory'])


  function! s:unite_my_settings()
    " Overwrite settings.
    nmap <buffer> l     <Plug>(unite_choose_action)
    nmap <buffer> <C-c>     <Plug>(unite_choose_action)

    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

    nmap <silent><buffer><expr> f unite#do_action('vimfiler')

    " grep bufferの時はrをreplaceアクションにマップする
    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^grep'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
            \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
  endfunction
  MyAutocmd FileType unite call s:unite_my_settings()
endfunction
unlet s:bundle
" }}}


" Gist.vim {{{
nnoremap [gist] <Nop>
nmap ,s [gist]
nnoremap [gist]g :Gist<CR>
nnoremap [gist]p :Gist -p<CR>
nnoremap [gist]e :Gist -e<CR>
nnoremap [gist]d :Gist -d<CR>
nnoremap [gist]l :Gist -l<CR>

let s:bundle = neobundle#get("gist-vim")
function! s:bundle.hooks.on_source(bundle)
  if has("mac")
    let g:gist_clip_command = 'pbcopy'
  elseif has("unix")
    let g:gist_clip_command = 'xclip -selection clipboard'
  endif

  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  let g:gist_show_privates = 1
endfunction
unlet s:bundle
" }}}

" Fugitive {{{
nnoremap [git] <Nop>
nmap ,g [git]
nnoremap [git]d :<C-u>Gdiff HEAD<CR>
nnoremap [git]s :<C-u>Gstatus<CR>
nnoremap [git]l :<C-u>Glog<CR>
nnoremap [git]a :<C-u>Gwrite<CR>
nnoremap [git]c :<C-u>Gcommit<CR>
nnoremap [git]C :<C-u>Git commit --amend<CR>
nnoremap [git]b :<C-u>Gblame<CR>
nnoremap [git]n :<C-u>Git now<CR>
nnoremap [git]N :<C-u>Git now --all<CR>

" ftdetect is often failed
MyAutocmd BufEnter * if expand("%") =~ ".git/COMMIT_EDITMSG" | set ft=gitcommit | endif
MyAutocmd BufEnter * if expand("%") =~ ".git/rebase-merge" | set ft=gitrebase | endif
" }}}

" project.vim
let g:proj_window_width = 48

" vimfiler {{{
nnoremap <silent> ,vf :<C-U>VimFiler<CR>

let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_max_directory_histories = 100
  function s:ChangeVimfilerKeymap()
    nmap <buffer> a <Plug>(vimfiler_toggle_mark_all_lines)

    " j k 移動でループしないように
    nmap <buffer> j j
    nmap <buffer> k k

    nmap <buffer> s <Plug>(vimfiler_select_sort_type)
    nmap <End> <Plug>(vimfiler_clear_mark_all_lines)
    nmap <buffer> @ <Plug>(vimfiler_set_current_mask)
    nmap <buffer> V <Plug>(vimfiler_quick_look)
  endfunction
  MyAutocmd FileType vimfiler call s:ChangeVimfilerKeymap()

  if filereadable(expand('~/.vimfiler.local'))
    execute 'source' expand('~/.vimfiler.local')
  endif
endfunction
unlet s:bundle
" }}}

" vimshell {{{
nnoremap <silent> ,vs :<C-U>VimShell<CR>

function! g:my_chpwd(args, context)
  call vimshell#execute('ls')
endfunction

let s:bundle = neobundle#get("vimshell")
function! s:bundle.hooks.on_source(bundle)
  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    let g:vimshell_prompt = $USER . "@" . hostname() . "% "
    if has('mac')
      call vimshell#set_execute_file('html', 'gexe open -a /Applications/Firefox.app/Contents/MacOS/firefox')
      call vimshell#set_execute_file('avi,mp4,mpg,ogm,mkv,wmv,mov', 'gexe open -a /Applications/MPlayerX.app/Contents/MacOS/MPlayerX')
    endif
  endif
  "let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b] ", "(%s)-[%b|%a] ") . "[" . getcwd() . "]"'
  let g:vimshell_right_prompt = '"[" . getcwd() . "]"'
  let g:vimshell_max_command_history = 3000

  MyAutocmd FileType vimshell
    \ call vimshell#altercmd#define('g', 'git')
    \| call vimshell#altercmd#define('l', 'll')
    \| call vimshell#altercmd#define('ll', 'ls -l')
    \| call vimshell#altercmd#define('be', 'bundle exec')
    \| call vimshell#altercmd#define('ra', 'rails')
    \| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

  function! s:EarthquakeKeyMap()
    nnoremap <buffer><expr> o OpenBrowserLine()
  endfunction
  MyAutocmd FileType int-earthquake call s:EarthquakeKeyMap()
endfunction
unlet s:bundle
" }}}

" rubycomplete.vim {{{
MyAutocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
let g:rubycomplete_rails = 0
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_include_object = 1
let g:rubycomplete_include_object_space = 1
" let ruby_operators = 1
" }}}

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" neosnippet {{{
nnoremap <Space>se :<C-U>NeoSnippetEdit<CR>
let s:bundle = neobundle#get('neosnippet')
function! s:bundle.hooks.on_source(bundle)
  let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

  " enable ruby & rails snippet only rails file
  function! s:RailsSnippet()
    if exists("b:rails_root") && (&filetype == "ruby")
      NeoSnippetSource ~/.vim/snippets/rails.snip
    endif
  endfunction

  function! s:RSpecSnippet()
    if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$")
      NeoSnippetSource ~/.vim/snippets/rspec.snip
    endif
  endfunction

  MyAutocmd BufEnter * call s:RailsSnippet()
  MyAutocmd BufEnter * call s:RSpecSnippet()
endfunction
unlet s:bundle
" }}}

" neocomplcache or neocomplete {{{

" Enable omni completion.
MyAutocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
MyAutocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
MyAutocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
MyAutocmd FileType python setlocal omnifunc=pythoncomplete#Complete
MyAutocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
MyAutocmd FileType sql setlocal omnifunc=sqlcomplete#Complete

if has('lua')
  let s:bundle = neobundle#get('neocomplete')
  function! s:bundle.hooks.on_source(bundle)
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1

    " Set minimum syntax keyword length.
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#manual_completion_start_length = 0
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#min_keyword_length = 2

    let g:neocomplete#enable_prefetch = 1

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME . '/.vimshell/command-history',
    \ }

    " キャッシュしないファイル名
    let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax'
    " 自動補完を行わないバッファ名
    let g:neocomplete#lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax'

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'


    " Plugin key-mappings.
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <expr><CR> neocomplete#smart_close_popup() . "\<CR>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplete#close_popup()

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    " for TweetVim スクリーン名のキャッシュを利用して、neocomplcache で補完する
    if !exists('g:neocomplete#sources#dictionary#dictionaries')
      let g:neocomplete#sources#dictionary#dictionaries = {}
    endif
    let neco_dic = g:neocomplete#sources#dictionary#dictionaries
    let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'

    " use clang_complete
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#force_omni_input_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.objc =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.objcpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

    " clang_complete
    let g:clang_complete_auto = 0
    let g:clang_auto_select = 0
    "let g:clang_use_library = 1
  endfunction
  unlet s:bundle
else
  let s:bundle = neobundle#get('neocomplcache')
  function! s:bundle.hooks.on_source(bundle)
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Use camel case completion.
    let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    "let g:neocomplcache_enable_underbar_completion = 1
    " Use fuzzy completion.
    " let g:neocomplcache_enable_fuzzy_completion = 1
    " filename width
    let g:neocomplcache_max_menu_width = 40
    " Set minimum syntax keyword length.
    let g:neocomplcache_auto_completion_start_length = 2
    let g:neocomplcache_manual_completion_start_length = 0
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_min_keyword_length = 2
    let g:neocomplcache_plugin_completion_length = {
    \ 'snippets_complete' : 1,
    \ }
    " let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplcache_enable_prefetch = 1

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME . '/.vimshell/command-history',
    \ }

    " キャッシュしないファイル名
    let g:neocomplcache_disable_caching_file_path_pattern = '\.log\|\.log\.\|\.jax'
    " 自動補完を行わないバッファ名
    let g:neocomplcache_lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax'

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    "imap <C-k> <Plug>(neosnippet_expand_or_jump)
    "smap <C-k> <Plug>(neosnippet_expand_or_jump)
    "inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
    " <TAB>: completion.
    "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()
    "inoremap <expr><C-e> neocomplcache#cancel_popup()

    " AutoComplPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1

    " Shell like behavior(not recommended).
    "setlocal completeopt+=longest
    "let g:neocomplcache_enable_auto_select = 1
    "let g:neocomplcache_disable_auto_complete = 1
    "inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
    "inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    " for TweetVim スクリーン名のキャッシュを利用して、neocomplcache で補完する
    if !exists('g:neocomplcache_dictionary_filetype_lists')
      let g:neocomplcache_dictionary_filetype_lists = {}
    endif
    let neco_dic = g:neocomplcache_dictionary_filetype_lists
    let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'
  endfunction
  unlet s:bundle
endif
" }}}

" ref.vim
let g:ref_open = 'vsplit'
let g:ref_refe_cmd = "rurema"
let g:ref_refe_version = 2
let g:ref_use_vimproc = 1

let g:ref_source_webdict_sites = {
\   'wikipedia:ja': 'http://ja.wikipedia.org/wiki/%s',
\   'weblio': 'http://ejje.weblio.jp/content/%s',
\ }

nmap ,rr :<C-U>Ref refe<Space>

" indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_color_change_percent = 35
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=DarkGrey   ctermbg=darkgrey
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=DarkCyan ctermbg=12
" }}}

" submode.vim {{{
let g:submode_timeout = 0
call submode#enter_with('window/manip', 'n', '', '<Leader>w')
call submode#enter_with('window/manip', 'n', '', '<C-W>-', '<C-W>-')
call submode#enter_with('window/manip', 'n', '', '<C-W>+', '<C-W>+')
call submode#enter_with('window/manip', 'n', '', '<C-W>>', '<C-W>>')
call submode#enter_with('window/manip', 'n', '', '<C-W><', '<C-W><')
call submode#leave_with('window/manip', 'n', '', '<Esc>')
call submode#map('window/manip', 'n', '', '-', '<C-W>-')
call submode#map('window/manip', 'n', '', '+', '<C-W>+')
call submode#map('window/manip', 'n', '', '<', '<C-W><')
call submode#map('window/manip', 'n', '', '>', '<C-W>>')
call submode#map('window/manip', 'n', '', '=', '<C-W>=')
call submode#map('window/manip', 'n', '', 'r', '<C-W>r')
call submode#map('window/manip', 'n', '', 'R', '<C-W>R')
call submode#map('window/manip', 'n', '', 'x', '<C-W>x')
call submode#map('window/manip', 'n', '', 'j', '<C-W>j')
call submode#map('window/manip', 'n', '', 'k', '<C-W>k')
call submode#map('window/manip', 'n', '', 'l', '<C-W>l')
call submode#map('window/manip', 'n', '', 'h', '<C-W>h')
" }}}

" vim-altr {{{
nmap <F3> <Plug>(altr-forward)
nmap <F2> <Plug>(altr-back)

let s:bundle = neobundle#get("vim-altr")
function! s:bundle.hooks.on_source(bundle)
  " For ruby tdd
  call altr#define('%.rb', 'spec/%_spec.rb')
  " For ruby tdd
  call altr#define('lib/%.rb', 'spec/lib/%_spec.rb', 'spec/%_spec.rb')
  " For rails tdd
  call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
  call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
  call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
endfunction
unlet s:bundle
" }}}

" toggle.vim {{{
imap <silent><C-C> <Plug>ToggleI
nmap <silent><C-C> <Plug>ToggleN
vmap <silent><C-C> <Plug>ToggleV

let g:toggle_pairs = {
  \'and':'or',
  \'or':'and',
  \'if':'unless',
  \'unless':'if',
  \'elsif':'else',
  \'else':'elsif',
  \'it':'specify',
  \'specify':'it',
  \'describe':"context",
  \'context':"describe",
  \'true':'false',
  \'false':'true',
  \'yes':'no',
  \'no':'yes',
  \'on':'off',
  \'off':'on',
  \'public':'protected',
  \'protected':'private',
  \'private':'public',
  \'&&':'||',
  \'||':'&&'
\}
" }}}

" RSpec syntax {{{
function! RSpecSyntax()
  hi def link rubyRailsTestMethod             Function
  syn keyword rubyRailsTestMethod describe context it its specify shared_examples_for shared_examples shared_context it_should_behave_like it_behaves_like before after around subject fixtures controller_name helper_name include_context include_examples
  syn match rubyRailsTestMethod '\<let\>!\='
  syn keyword rubyRailsTestMethod violated pending expect double mock mock_model stub_model an_instance_of hash_including
  syn match rubyRailsTestMethod '\.\@<!\<stub\>!\@!'
endfunction
MyAutocmd Syntax ruby if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$") | call RSpecSyntax() | endif
" }}}

" Quickfix
augroup quickfixopen
  autocmd!
  autocmd QuickfixCmdPost make cw
augroup END

nnoremap <silent> ,q :<C-U>copen<CR>
nnoremap <silent> ]q :<C-U>cnext<CR>
nnoremap <silent> [q :<C-U>cprev<CR>
nnoremap <silent> ]Q :<C-U>clast<CR>
nnoremap <silent> [Q :<C-U>cfirst<CR>

" errormarker.vim
let errormarker_disablemappings = 1

" Merge Setting
if &diff
  nmap <buffer> <leader>1 :diffget LOCAL<CR>
  nmap <buffer> <leader>2 :diffget BASE<CR>
  nmap <buffer> <leader>3 :diffget REMOTE<CR>
endif

" TagBar
nnoremap <silent> ,t :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_updateonsave_maxlines = 10000
let g:tagbar_sort = 0

" Tabular
nnoremap <Leader>a, :Tabularize /,<CR>
vnoremap <Leader>a, :Tabularize /,<CR>
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a> :Tabularize /=><CR>
vnoremap <Leader>a> :Tabularize /=><CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
vnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>

" テーブルっぽく打つと自動的に位置調整を行う
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" gundo
nnoremap U :<C-U>GundoToggle<CR>

" qfreplace
MyAutocmd FileType qf nnoremap <buffer> r :<C-U>Qfreplace<CR>

" sudo.vim
command! ES :e sudo:%
command! WS :w sudo:%

" open-browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)
function! OpenBrowserLine()
  let matched = matchlist(getline("."), 'https\?://[0-9A-Za-z_#?~=\-+%\.\/:]\+')
  if len(matched) == 0
    break
  endif
  execute "OpenBrowser " . matched[0]
endfunction

" syntastic
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['haskell'] }

" ft hamstache
MyAutocmd BufReadPost *.hamstache set filetype=haml

" ag.vim
let g:agprg="ag --nocolor --nogroup --column"

" ruby buffer
if has('ruby')
    nnoremap <silent> [space]r :set operatorfunc=Ruby<CR>g@
    nnoremap <silent> [space]rr :call RubyLines()<CR>
    nmap [space]R [space]r$
    nnoremap <silent> [space]rp :<C-u>call RubyPaste()<CR>

    xnoremap <silent> [space]r :<C-u>call Ruby(visualmode(), 1)<CR>
    xnoremap <silent> [space]R :<C-u>call Ruby('V', 1)<CR>

    command! -range Ruby :<line1>,<line2>call RubyLines()
    command! -range RubyPaste :<line1>,<line2>call RubyPaste()

    let s:ruby_buffer = ""

    ruby <<RUBY
class VimRuby
    @@binding = binding

    def VimRuby.evaluate(code)
        result = eval(code, @@binding)

        if result.instance_of?(String)
            str = result.gsub(/"/, '\\"')
            VIM.command(%(let s:ruby_buffer = "#{str}" . "\n"))
        else
            str = result.inspect.gsub(/"/, '\\"')
            VIM.command(%(let s:ruby_buffer = '#{str}' . "\n"))
        end

        return result
    end
end
RUBY

    function! RubyEval(code)
        ruby p VimRuby.evaluate(VIM.evaluate("a:code"))
    endfunction

    function! Ruby(type, ...)
        let saved_sel = &selection
        let &selection = "inclusive"
        let saved_reg = @*

        if a:0
            silent exe "normal! `<" . a:type . "`>y"
        elseif a:type == 'line'
            silent exe "normal! '[V']y"
        elseif a:type == 'block'
            silent exe "normal! `[\<C-v>`]y"
        else
            silent exe "normal! `[v`]y"
        endif

        call RubyEval(@*)

        let &selection = saved_sel
        let @* = saved_reg
    endfunction

    function! RubyLines() range
        let lines = getline(a:firstline, a:lastline)
        let code = join(lines, "\n")
        call RubyEval(code)
    endfunction

    function! RubyPaste()
        let saved_reg = @*
        let @* = s:ruby_buffer
        normal! p
        let @* = saved_reg
    endfunction
endif

" TweetVim {{{
nnoremap <silent> S :<C-u>TweetVimSay<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tweetvim<CR>
nnoremap <silent> [space]ts   :<C-u>TweetVimUserStream<CR>
nnoremap <silent> [space]tt   :<C-u>TweetVimHomeTimeline<CR>
let s:bundle = neobundle#get("TweetVim")
function! s:bundle.hooks.on_source(bundle)
  let g:tweetvim_include_rts = 1
  if has('mac')
    let g:tweetvim_display_icon = 0
  else
    let g:tweetvim_display_icon = 1
  end
endfunction
unlet s:bundle
" }}}

" code snippet highlight {{{
let g:markdown_quote_syntax_filetypes = {
        \ "coffee" : {
        \   "start" : "coffee",
        \},
        \ "mustache" : {
        \   "start" : "mustache",
        \},
        \ "haml" : {
        \   "start" : "haml",
        \},
  \}
" }}}

" accelerated-smooth-scroll
let g:ac_smooth_scroll_du_sleep_time_msec = 5
let g:ac_smooth_scroll_fb_sleep_time_msec = 5

" to 1.9 hash
vnoremap <silent> <C-h> :s/:\([a-z0-9_]\+\)\s*=>/\1:/g<CR>


if filereadable(expand('~/.vimrc.local.after'))
  execute 'source' expand('~/.vimrc.local.after')
endif

