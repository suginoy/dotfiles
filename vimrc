" encoding
set fileencodings=utf-8,cp932,eucjp

" pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
filetype on

syntax on
filetype plugin indent on

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

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set backupdir=~/.vim/backup
set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set ambiwidth=double

" 行番号を表示
set nu
MyAutocmd InsertLeave * setlocal nocursorline
MyAutocmd InsertEnter * setlocal cursorline

" タブストップ設定
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

" 検索設定
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

" ステータスライン表示
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%{exists('*SkkGetModeStr')?SkkGetModeStr():''}%=%l/%L,%c%V%8P
set wildmenu
set cmdheight=2
set wildmode=list:full
set showcmd

" completion
set complete=.,w,b,u,t,i,d,k

" クリップボード設定
set clipboard=unnamed

" バッファ切り替え
set hidden
set list
set listchars=tab:>-

" タイトルを表示
set title

" 対応括弧を表示
set showmatch

" 自動折り返しを日本語に対応させるスクリプト用の設定
set formatoptions+=mM

" matchitスクリプトの読み込み
source $VIMRUNTIME/macros/matchit.vim

" 括弧の入力補助
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i

nmap ,( csw(
nmap ,{ csw{
nmap ,[ csw[

nmap ,' csw'
nmap ," csw"


" JとDで半ページ移動
nnoremap J <C-D>
nnoremap K <C-U>

" colorscheme
if stridx($TERM, "xterm-256color") >= 0
  colorscheme desert256
else
  colorscheme desert
endif


" 256色モード
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif

" skk
let skk_jisyo            = '~/.skk-jisyo'
let skk_large_jisyo      = '~/.vim/dict/skk/SKK-JISYO.L'
let skk_auto_save_jisyo  = 1
let skk_keep_state       = 0
let skk_egg_like_newline = 1
let skk_show_annotation  = 1
let skk_use_face         = 1
let skk_imdisable_state  = 0
let skk_sticky_key       = ';'

" UTF8、SJIS(CP932)、EUCJPで開き直す
command! -bang -nargs=? Utf8
	\ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis
	\ edit<bang> ++enc=cp932 <args>
command! -bang -nargs=? Euc
	\ edit<bang> ++enc=eucjp <args>

" mark, register確認
nnoremap ,m  :<C-u>marks<CR>
nnoremap ,r  :<C-u>registers<CR>

" YAMLファイル用タブストップ設定
au FileType yaml set expandtab ts=2 sw=2 fenc=utf-8

" actionscript mxml用のファイルタイプ設定
MyAutocmd BufNewFile,BufRead *.as set filetype=actionscript
MyAutocmd BufNewFile,BufRead *.mxml set filetype=mxml

" yanktmp用キー設定
map <silent> sy :call YanktmpYank()<CR> 
map <silent> sp :call YanktmpPaste_p()<CR> 
map <silent> sP :call YanktmpPaste_P()<CR> 

" miniBufExplorer設定
let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBuffs = 1
let g:miniBufExplModSelTarget       = 1
" バッファ切り替え
nmap <Space> :MBEbn<CR>
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

" NERDTree
nmap <silent> <Leader>t :NERDTreeToggle<CR>

" smooth_scroll
nnoremap <PageUp> <C-B>
nnoremap <PageDown> <C-F>

" smartchr
inoremap <buffer><expr> + smartchr#one_of(' + ', '++', '+')
inoremap <buffer><expr> - smartchr#one_of(' - ', '--', '-')
inoremap <buffer><expr> / smartchr#one_of(' / ', '// ', '/')
inoremap <buffer><expr> & smartchr#one_of(' & ', ' && ', '&')
inoremap <buffer><expr> % smartchr#one_of(' % ', '%')
inoremap <buffer><expr> , smartchr#one_of(', ', ',')
inoremap <buffer><expr> <Bar> smartchr#one_of(' <Bar> ',  ' <Bar><Bar> ',  '<Bar>')
inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= '
        \ : search('\(*\<bar>!\)\%#', 'bcn') ? '= '
        \ : smartchr#one_of(' = ', ' == ', '=')


" QFixHowm用設定=========================================================
set runtimepath+=~/qfixapp

"キーマップリーダー
let QFixHowm_Key = 'g'

"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir          = '~/Dropbox/howm'
let howm_filename     = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding = 'utf-8'
let howm_fileformat   = 'dos'

if has('win32')
  let mygrepprg = 'yagrep'
elseif has('unix')
  let mygrepprg = 'grep'
endif

let QFixHowm_MruFileMax = 30

let QFixHowm_RecentMode = 2


"ブラウザの指定
if has('win32')
  let QFixHowm_OpenURIcmd = '!start "C:\firefox-3.5.3-2009100400.en-US.win32-tete009-sse2-pgo\firefox.exe" %s'
elseif has('mac')
  let QFixHowm_OpenURIcmd = "call system('/usr/bin/open -a /Applications/Firefox.app/Contents/MacOS/firefox-bin %s')"
elseif has('unix')
  let QFixHowm_OpenURIcmd = "call system('firefox %s &')"
endif
" QFixHowm用設定 end=====================================================



" AutoComplPop===========================================================
let g:acp_completeOption = '.,w,b,u,t,i,d,k'
inoremap <silent> <expr> <F12>
      \ (exists('#AcpGlobalAutoCommand#InsertEnter#*')) ? "\<C-o>:AutoComplPopDisable\<CR>\<C-o>:echo 'AutoComplPop Disabled'\<CR>" : "\<C-o>:AutoComplPopEnable\<CR>\<C-o>:echo 'AutoComplPop Enabled'\<CR>"
noremap <silent> <expr> ,a
      \ (exists('#AcpGlobalAutoCommand#InsertEnter#*')) ? ":AutoComplPopDisable<CR>:echo 'AutoComplPop Disabled'<CR>" : ":AutoComplPopEnable<CR>:echo 'AutoComplPop Enabled'<CR>"
" ポップアップメニューのカラーを設定
hi Pmenu ctermbg=18 guibg=#666666
hi PmenuSel ctermbg=39 ctermfg=0 guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333
"<C-Space>でomni補完
imap <C-Space> <C-x><C-o>
" AutoComplPop end=======================================================


" rubycomplete.vim
MyAutocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
MyAutocmd FileType ruby,eruby let g:rubycomplete_rails = 1
MyAutocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
MyAutocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1


" FuzzyFinder
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>fb :FufBuffer<CR>
nnoremap <Leader>fd :FufDir<CR>

" Unite
nnoremap <silent> <Leader>uf  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> <Leader>ub  :<C-u>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> <Leader>ur  :<C-u>Unite -buffer-name=register register<CR>
nnoremap  <Leader>uu  :<C-u>Unite source<CR>


" Gist.vim
nnoremap <silent> ,gs :Gist<CR>
nnoremap <silent> ,gp :Gist -p<CR>
nnoremap <silent> ,ge :Gist -e<CR>
nnoremap <silent> ,gd :Gist -d<CR>
nnoremap <silent> ,gl :Gist -l<CR>


" neocomplcache===================================================
 " Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" filename width
let g:neocomplcache_max_filename_width = 30
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_plugin_completion_length = {
\ 'snippets_complete' : 1,
\ }
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" quick_match (-を押せば英数字で補完を選択できる)
let g:neocomplcache_enable_quick_match = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ }
let g:neocomplcache_snippets_dir = ''

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"setlocal completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
MyAutocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
MyAutocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
MyAutocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
MyAutocmd FileType python setlocal omnifunc=pythoncomplete#Complete
MyAutocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" neocomplcache end===================================================


if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif
