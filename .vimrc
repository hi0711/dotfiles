"  |    _)  _ \___  |_ |_ |
"  __ \  | |   |   /   |  |
"  | | | | |   |  /    |  |
" _| |_|_|\___/ _/    _| _|
" ----------------------------------------
" Start NeoBundle Settings
" ----------------------------------------
"{{{
" Note: Skip initialization for vim-tiny or vim-small.
  if !1 | finish | endif
  if has('vim_starting')
    if &compatible
      set nocompatible               " Be iMproved
    endif
    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
  " Required:
  call neobundle#begin(expand('~/.vim/bundle/'))
  " Let NeoBundle manage NeoBundle
  " Required:
   NeoBundleFetch 'Shougo/neobundle.vim'
   NeoBundle 'Shougo/unite.vim'
   NeoBundle 'Shougo/neomru.vim'
   NeoBundle 'Shougo/vimproc.vim', {
   \ 'build' : {
   \     'windows' : 'tools\\update-dll-mingw',
   \     'cygwin' : 'make -f make_cygwin.mak',
   \     'mac' : 'make',
   \     'linux' : 'make',
   \     'unix' : 'gmake',
   \    },
   \ }
" neocompleteプラグイン
  NeoBundle 'Shougo/neocomplete'
  " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
  " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 1
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
  " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
" neosnippetプラグイン
  NeoBundle 'Shougo/neosnippet.vim'
  " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
  " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
  " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
" neosnippet-snippetsプラグイン
  NeoBundle 'Shougo/neosnippet-snippets'
" syntasticプラグイン
  NeoBundle 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_ruby_checkers = ['rubocop']
  let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["ruby", "javascript"],
    \ "passive_filetypes": ["html"] }
" auto-ctagsプラグイン
  NeoBundle 'soramugi/auto-ctags.vim'
  let g:auto_ctags = 1
  let g:auto_ctags_directory_list = ['.git']
  set tags=.git/tags
" autodateプラグイン
  NeoBundle 'vim-scripts/autodate.vim'
  :let autodate_keyword_pre = '\[Date:'
  :let autodate_keyword_post = '\]'
  :let autodate_format="%Y/%m/%d"
" sorround.vimプラグイン
  NeoBundle 'vim-scripts/surround.vim'
" open-browserプラグイン
  NeoBundle 'tyru/open-browser.vim'
" ctrlpプラグイン
  NeoBundle 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_extensions = ['tag', 'dir', 'line', 'mixed']
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
  let g:ctrlp_open_new_file = 1
  let g:ctrlp_mruf_max = 500
" agプラグイン
  NeoBundle 'rking/ag.vim'
  if executable('ag')
    let g:ctrlp_use_caching=0
    let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
  endif
" qfreplaceプラグイン
  NeoBundle 'thinca/vim-qfreplace'
" emmetプラグイン
  NeoBundle 'mattn/emmet-vim'
  let g:user_emmet_settings = {
    \  'php' : {
    \    'extends' : 'html',
    \    'filters' : 'c',
    \  },
    \  'xml' : {
    \    'extends' : 'html',
    \  },
    \  'haml' : {
    \    'extends' : 'html',
    \  },
    \}
" indentLineプラグイン
  NeoBundle 'Yggdroot/indentLine'
  let g:indentLine_char='|'
" easy-alignプラグイン
  NeoBundle 'junegunn/vim-easy-align'
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
"JpFormatプラグイン
  NeoBundle "fuenor/JpFormat.vim"
  nnoremap gL :JpFormatAll!<CR>
" lightline プラグイン
  NeoBundle 'itchyny/lightline.vim'
  let g:lightline = {
        \ 'colorscheme': 'wombat'
        \ }
" tlibプラグイン
  NeoBundle 'tomtom/tlib_vim'
" ttocプラグイン
  NeoBundle 'tomtom/ttoc_vim'
  nnoremap <Leader>tt :TToC<CR>
" autocloseプラグイン
  NeoBundle 'Townk/vim-autoclose'
" coffeescriptプラグイン
  NeoBundle 'kchmck/vim-coffee-script'
" jadeプラグイン
  NeoBundle 'digitaltoad/vim-jade'
" jshintプラグイン
  NeoBundle 'wookiehangover/jshint.vim'
" vim-lessプラグイン
  NeoBundle 'groenewege/vim-less'
" vim-matchitプラグイン
  NeoBundle 'tmhedberg/matchit'
" vimwikiプラグイン
  NeoBundle 'vim-scripts/vimwiki'
" iceberg カラースキーム
  NeoBundle 'cocopon/iceberg.vim'
" markdownプラグイン
  NeoBundle 'plasticboy/vim-markdown'
  let g:vim_markdown_folding_disabled = 1

call neobundle#end()
" Required:
  filetype plugin indent on
NeoBundleCheck
"}}}
" ----------------------------------------
"  Basic Settings
" ----------------------------------------
"{{{
let mapleader="\<Space>"
set ruler
set nu
set modifiable
set write
set backspace=2
set list
set listchars=tab:»-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%
set showcmd
set wrap
set textwidth=0
set display=lastline
set title
set showmatch
set matchtime=1
set tabstop=2
set shiftwidth=2
set smartindent
set expandtab
set smarttab
set fdm=marker
set ambiwidth=double
set history=1000
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
set clipboard=unnamed,autoselect
set laststatus=2
set nrformats-=octal
set diffopt=vertical
set pumheight=10
set ttyfast
set lazyredraw
set hidden
set formatoptions+=t
set wildmenu
set wildchar=<TAB>
set wildmode=longest:full,full
set visualbell t_vb=
set virtualedit+=all
set scrolloff=6
" netrwは常にtree view
  let g:netrw_liststyle=3
" 改行時の設定
  autocmd FileType * setlocal formatoptions-=ro
" backupファイルとスワップファイルの設定
  set backup
  set backupdir=~/.vim/backup
  set swapfile
  set directory=~/.vim/swap
  set backupskip=/tmp/*,/private/tmp/*
" insertモードでカーソルの形を変える
  if !has('gui_running')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
" 保存時に行末の空白を除去する
  function! s:remove_dust()
    let cursor = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
  endfunction
  autocmd BufWritePre *.html,*.css,*.scss,*.sass,*.less,*.php,*.rb,*.js,*.haml,*.erb,*.txt,*.ejs call <SID>remove_dust()
" 全角スペースの設定
  function! ZenkakuSpace()
      highlight ZenkakuSpace cterm=reverse ctermfg=darkgray gui=reverse guifg=darkgray
  endfunction
  if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
  endif
"virtualモードの時にスターで選択位置のコードを検索するようにする
  xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
  function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction
"ステータスラインに情報を表示する
  set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" エンコード設定
  set encoding=utf-8
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,euc-jp,cp932
  command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
  command! -bang -nargs=? Sjis edit<bang> ++enc=sjis <args>
  command! -bang -nargs=? Euc edit<bang> ++enc=euc-jp <args>
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
      let &fileencodings = &fileencodings .','. s:fileencodings_default
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
  " 日本語を含まない場合は fileencoding に encoding を使うようにする
  if has('autocmd')
    function! AU_ReCheck_FENC()
      if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding=&encoding
      endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
  endif
  " 改行コードの自動認識
  set fileformats=unix,dos,mac
" undo記憶、undoファイルの生成
  if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
  endif
" ファイルを閉じた時の位置から再編集
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""
" 削除でレジスタに格納しない(ビジュアルモードでの選択後は格納する)
"   nnoremap x "_x
"   nnoremap dd "_dd
" vimdiffの設定
  function! s:vimdiff_in_newtab(...)
    if a:0 == 1
      tabedit %:p
      exec 'rightbelow vertical diffsplit ' . a:1
    else
      exec 'tabedit ' . a:1
      for l:file in a:000[1 :]
        exec 'rightbelow vertical diffsplit ' . l:file
      endfor
    endif
  endfunction
  command! -bar -nargs=+ -complete=file Diff  call s:vimdiff_in_newtab(<f-args>)
" grep後にcwinを表示
  autocmd QuickFixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
"}}}
" ----------------------------------------
"  キーマッピング設定
" ----------------------------------------
"{{{
" Yを行末までのヤンクにする
  nnoremap Y y$
" スペースキー + . で.vimrcを開く
  nnoremap <Space>. :<C-u>tabedit ~/.vimrc<CR>
" 数値のインクリメント、ディクリメント
"   nnoremap <C-a> +
"   nnoremap <C-x> -
" 検索語が画面の真ん中に来るようにする
  nmap n nzz
  nmap N Nzz
  nmap * *zz
  nmap # #zz
  nmap g* g*zz
  nmap g# g#zz
" insertモードから抜ける
  inoremap jj <ESC>:up<CR>
  inoremap <C-j> <ESC>:up<CR>
" カーソル操作
  inoremap <C-a> <Home>
  inoremap <C-e> <End>
  inoremap <C-f> <Right>
  inoremap <C-b> <Left>
  inoremap "" ""<LEFT>
  inoremap %% %%<LEFT><Space><LEFT>
  inoremap '' ''<LEFT>
  inoremap () ()<LEFT>
  inoremap <> <><LEFT>
  inoremap [] []<LEFT>
  inoremap {} {}<LEFT>
" テキストオブジェクト操作
  onoremap id i"
  onoremap is i'
  onoremap ia i>
  onoremap ir i]
" 移動を表示行単位に
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k
" 現在行を入れ替える
  nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
  nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" 半ページ移動(中央維持
  noremap H <C-u>zz
  noremap L <C-d>zz
" insertモードで次の行に直接改行
  inoremap <C-o> <Esc>o
" cntrl + n キーで改行
  noremap <C-n> o<Esc>
" バッファの分割
  noremap <silent><Leader>sp :<C-u>split<CR>
  noremap <silent><Leader>vs :<C-u>vsplit<CR>
" カーソルキーでバッファのサイズ変更
  nnoremap <silent><Down>  <C-w>-
  nnoremap <silent><Up>    <C-w>+
  nnoremap <silent><Left>  <C-w><
  nnoremap <silent><Right> <C-w>>
" ファイル操作
  nnoremap <Leader>w :<C-u>w<CR>
  nnoremap <Leader>Q :<C-u>q!<CR>
" 置換操作
  nnoremap gs :<C-u>%s///g<Left><Left><Left>
  vnoremap gs :s///g<Left><Left><Left>
" ハードタブ置換
  vnoremap <silent> <Leader>tab :s/,/\t/g<CR>
" 同単語検索設定
  nnoremap * *N
" タブ操作
  nnoremap <silent> <Leader>ta :<C-u>tabe<CR>
  nnoremap <silent> <Leader>tn gt
  nnoremap <silent> <Leader>tp gT
  nnoremap <silent> <Leader>tc :<C-u>tabc<CR>
" 全角で書かないようにする
  inoremap （ (
  inoremap ） )
  inoremap ｛ {
  inoremap ｝ }
  inoremap ； ;
  inoremap ： :
  inoremap ｜ \|
  inoremap ＜ <
  inoremap ＞ >
  inoremap ＊ *
  inoremap ＠ @
  inoremap － -
  inoremap ％ %
  inoremap ＃ #
  inoremap ” "
  inoremap ’ '
  inoremap ＋ +
  inoremap ０ 0
  inoremap １ 1
  inoremap ２ 2
  inoremap ３ 3
  inoremap ４ 4
  inoremap ５ 5
  inoremap ６ 6
  inoremap ７ 7
  inoremap ８ 8
  inoremap ９ 9
" ウインドウのフォーカス移動
  map  gh <C-w>h
  map  gl <C-w>l
  map  gj <C-w>j
  map  gk <C-w>k
  " map gl :macaction selectNextWindow:<CR>
  " map gh :macaction selectPreviousWindow:<CR>
" キー入れ替え
  noremap ; :
  noremap : ;
" vimgrep時の候補移動
  nnoremap <silent>[q :cprevious<CR>zz
  nnoremap <silent>]q :cnext<CR>zz
  nnoremap <silent>[Q :<C-u>cfirst<CR>
  nnoremap <silent>]Q :<C-u>clast<CR>
" hlsearchの解除
  nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" .vimrcの再読み込み
  nnoremap <Leader>so :<C-u>source ~/.vimrc<CR>
"文字コード変更して再読み込み
  nnoremap <silent> eu :<C-u>e ++enc=utf-8<CR>
" コマンドライン設定
  cnoremap <C-a> <Home>
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>
  cnoremap <C-d> <Del>
  cnoremap <C-e> <End>
  cnoremap <C-n> <Down>
  cnoremap <C-p> <Up>
"}}}
" ----------------------------------------
"  テンプレート設定
" ----------------------------------------
"{{{
autocmd BufNewFile  *.wiki  0r ~/.vim/template/wiki.txt
"}}}
" ----------------------------------------
"  Unite.vim の設定
" ----------------------------------------
"{{{
" prefix
  nnoremap [unite] <Nop>
  nmap <Leader>u [unite]
" insert modeで開始
  let g:unite_enable_start_insert = 0
" yankのhistory読み込み
  let g:unite_source_history_yank_enable =1
" 大文字・小文字を無視
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
" ファイル履歴保存数
  let g:unite_source_file_mru_limit =50
" キーマッピング
  nnoremap <silent> [unite]u :<C-u>Unite<Space>file<CR>
  nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>
  nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
  nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
  nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
  nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
  nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> <Leader>vr :UniteResume<CR>
  nnoremap <silent> <Leader>rr <Plug>(unite-restart)
" unite-grep
" unite-grepのバックエンドをagに切り替える
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 200
" unite-grepのキーマップ
" 選択した文字列をunite-grep
  vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
" カーソル位置の単語をgrep検索
  nnoremap <silent> <Leader>cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" ウィンドウを分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-x> unite#do_action('split')
  au FileType unite inoremap <silent> <buffer> <expr> <C-x> unite#do_action('split')
" ウィンドウを縦に分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
  au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
"}}}
" ----------------------------------------
" HTML閉じタグ自動補完
" ----------------------------------------
"{{{
augroup MyTag
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END
"}}}
" ----------------------------------------
"  色設定
" ----------------------------------------
"{{{
" カラースキーム決定
  set t_Co=256
  syntax enable
  colorscheme iceberg
" vimdiffの色設定
  hi clear Diff
  hi DiffAdd    cterm=bold ctermfg=10 ctermbg=22
  hi DiffDelete cterm=bold ctermfg=10 ctermbg=52
  hi DiffChange cterm=bold ctermfg=10 ctermbg=17
  hi DiffText   cterm=bold ctermfg=10 ctermbg=21
" ビジュアルモード色設定
  hi clear Visual
  hi Visual term=reverse ctermfg=253 ctermbg=202
" カーソルライン設定
  set cursorline
  augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
  augroup END
  hi clear CursorLine
  hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" エラー表示
  hi clear SpellBad
  hi SpellBad cterm=bold ctermfg=219 ctermbg=NONE
"}}}
