"  |    _)  _ \___  |_ |_ |
"  __ \  | |   |   /   |  |
"  | | | | |   |  /    |  |
" _| |_|_|\___/ _/    _| _|
" ----------------------------------------
" Start dein settings
" ----------------------------------------
if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
filetype plugin indent on
" }}}
" ----------------------------------------
"  Basic Settings
" ----------------------------------------
"{{{
let mapleader="\<Space>"
let g:yankring_clipboard_monitor=0
set ambiwidth=double
set backspace=2
set clipboard=unnamed
set diffopt=vertical
set display=lastline
set expandtab
set fdm=marker
set formatoptions+=t
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:»-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%
set matchtime=1
set modifiable
set nrformats-=octal
set nu
set pumheight=10
set ruler
set scrolloff=6
set sh=zsh
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set tabstop=2
set textwidth=0
set title
set ttyfast
set virtualedit+=all
set visualbell t_vb=
set wildchar=<TAB>
set wildmenu
set wildmode=longest:full,full
set wrap
set wrapscan
set write
" breakindent設定
  if exists('+breakindent')
    set breakindent
  endif
" netrwは常にtree view
  let g:netrw_liststyle=3
" 改行時の設定
  autocmd FileType * setlocal formatoptions-=ro
" backupファイルとスワップファイルの設定
  set backup
  set backupdir=~/.config/nvim/backup
  set swapfile
  set directory=~/.config/nvim/swap
  set backupskip=/tmp/*,/private/tmp/*
" insertモードでカーソルの形を変える
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" 保存時に行末の空白を除去する
  function! s:remove_dust()
    let cursor = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
  endfunction
  autocmd BufWritePre *.html,*.css,*.scss,*.sass,*.less,*.php,*.rb,*.js,*.haml,*.erb,*.txt,*.ejs,*.jade call <SID>remove_dust()
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
" undo記憶、undoファイルの生成
  if has('persistent_undo')
    set undodir=~/.config/nvim/undo
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
"  filetype settings
" ----------------------------------------
"{{{
  augroup filetypeset
    au BufRead, BufNewFile *.py setfiletype python
    au BufRead, BufNewFile *.rb setfiletype ruby
    au BufRead, BufNewFile *.php setfiletype php
  augroup END
"}}}
" ----------------------------------------
"  キーマッピング設定
" ----------------------------------------
"{{{
" Yを行末までのヤンクにする
  nnoremap Y y$
" スペースキー + . で.vimrcを開く
  nnoremap <Space>. :<C-u>tabedit ~/.config/nvim/init.vim<CR>
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
  onoremap ib i)
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
" relativenumberのトグル
  nnoremap <Leader>nu :setlocal rnu!<CR>
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
" ファイルエクスプローラー系
  nnoremap <silent><Leader>ex :<C-u>e .<CR>
  nnoremap <silent><Leader>sex :<C-u>Sex<CR>
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
  nnoremap <Leader>so :<C-u>source ~/.config/nvim/init.vim<CR>
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
" ターミナルモードの設定
  tnoremap <silent><ESC><ESC> <C-\><C-n>
"}}}
" ----------------------------------------
" Qfixhowmの設定
" ----------------------------------------
"{{{
let QFixHowm_key = 'g'
let howm_dir = '~/Gdrive/howm'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let howm_fileencoding = 'utf-8'

" プレビューや絞り込みをQuickFix/ロケーションリストの両方で有効化
let QFixWin_EnableMode = 1

" QFixHowmのファイルタイプ
let QFixHowm_FileType = 'markdown'

" タイトル記号を#に変更する
let QFixHowm_Title = '#'

" QFixHowm/QFixGrepの結果表示にロケーションリストを使用する/しない
let Qfix_UseLocationList = 1

set shellslash

" textwidthの再セット
au Filetype qfix_memo setlocal textwidth = 0

" オートリンクでファイルを開く
let QFixHowm_Wiki = 1
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
" ----------------------------------------
"  色設定
" ----------------------------------------
"{{{
" カラースキーム決定
  set t_Co=256
  syntax enable
" vimdiffの色設定
  hi clear Diff
  hi DiffAdd    cterm=bold ctermfg=10 ctermbg=22
  hi DiffDelete cterm=bold ctermfg=10 ctermbg=52
  hi DiffChange cterm=bold ctermfg=10 ctermbg=17
  hi DiffText   cterm=bold ctermfg=10 ctermbg=21
" カーソルライン設定
  set cursorline
  "augroup cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
  "augroup END
  au MyAutoCmd VimEnter * hi clear CursorLine
  au MyAutoCmd VimEnter * hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" エラー表示
  hi clear SpellBad
  au MyAutoCmd VimEnter * hi SpellBad cterm=bold ctermfg=219 ctermbg=NONE
" 改行文字とタブ文字の色設定
  au MyAutoCmd VimEnter * hi SpecialKey ctermfg=237 guifg=#3a3a3a
  au MyAutoCmd VimEnter * hi NonText ctermfg=66 guifg=#5f8787
" ビジュアルモード色設定
  hi clear Visual
  au MyAutoCmd VimEnter * hi Visual term=reverse ctermfg=16 ctermbg=225
"}}}
