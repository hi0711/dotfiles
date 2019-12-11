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
  call dein#load_toml(s:lazy_toml)
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
nnoremap s <Nop>
nnoremap <Space> <Nop>
let mapleader="\<Space>"
let g:yankring_clipboard_monitor=0
set ambiwidth=double
set backspace=2
set clipboard=unnamed
set diffopt=vertical
set display=lastline
set expandtab
set fdm=marker
set fencs=utf-8,sjis,euc-jp
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
set so=7
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
set updatetime=250
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
  autocmd BufWritePre *.html,*.css,*.scss,*.sass,*.less,*.php,*.rb,*.js,*.haml,*.erb,*.txt,*.ejs,*.jade,*.pug call <SID>remove_dust()
" 全角スペースの設定
  function! ZenkakuSpace()
      highlight ZenkakuSpace cterm=reverse ctermfg=darkgray gui=reverse guifg=darkgray
  endfunction
  if has('syntax')
    augroup ZenkakuSpace
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
" Rename {新しいファイル名}
  command! -nargs=1 -complete=file Rename file <args> | call delete(expand('#'))
"}}}

" ----------------------------------------
"  filetype settings
" ----------------------------------------
"{{{
  augroup filetypeSet
    au!
    au BufRead,BufNewFile *.py set filetype=python
    au BufRead,BufNewFile *.rb set filetype=ruby
    au BufRead,BufNewFile *.ejs set filetype=mason
  augroup END
  augroup filetypeIndent
    au!
    au BufNewFile,BufRead *.scss set tabstop=4 shiftwidth=4
    au BufNewFile,BufRead *.css set tabstop=2 shiftwidth=2
    au BufNewFile,BufRead *.php set tabstop=4 shiftwidth=4
    au BufNewFile,BufRead *.go set tabstop=4 shiftwidth=4 noexpandtab
    au BufNewFile,BufRead *.js set tabstop=4 shiftwidth=4
    au BufNewFile,BufRead *.pug set tabstop=2 shiftwidth=2
  augroup END
"}}}

" ----------------------------------------
"  コード別aleの設定
" ----------------------------------------

let g:ale_linters = {
    \ 'php': ['phpcs'],
\}

let g:ale_php_phpcs_executable = '/usr/local/bin/phpcs'
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_use_global = 1

" ----------------------------------------
"  キーマッピング設定
" ----------------------------------------
"{{{
" Yを行末までのヤンクにする
  nnoremap Y y$
" 閉じ括弧補完
  inoremap " ""<ESC>i
  inoremap ' ''<ESC>i
  inoremap { {}<ESC>i
  inoremap {<Enter> {}<Left><CR><ESC><S-o>
  inoremap ( ()<ESC>i
  inoremap (<Enter> ()<Left><CR><ESC><S-o>
  inoremap [ []<ESC>i
  inoremap [<Enter> []<Left><CR><ESC><S-o>
  inoremap < <><ESC>i
" スペースキー + . で.vimrcを開く
  nnoremap <Leader>. :<C-u>tabedit ~/.config/nvim/init.vim<CR>
" 検索語が画面の真ん中に来るようにする
  nmap n nzz
  nmap N Nzz
  nmap * *zz
  nmap # #zz
  nmap g* g*zz
  nmap g# g#zz
" 行の真ん中に移動
  nnoremap <Leader>c :call cursor(0,strlen(getline("."))/2)<CR>
" 行の最後尾に移動
  nnoremap <Leader>e $
" insertモードから抜ける
  inoremap jj <ESC>:up<CR>
  inoremap <C-j> <ESC>:up<CR>
" カーソル操作
  inoremap <C-a> <Home>
  inoremap <C-e> <End>
  inoremap <C-f> <Right>
  inoremap <C-b> <Left>
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
  noremap <silent><Leader><Leader>sp :<C-u>split<CR>
  noremap <silent><Leader><Leader>vs :<C-u>vsplit<CR>
" カーソルキーでバッファのサイズ変更
  nnoremap <silent><Down>  <C-w>-
  nnoremap <silent><Up>    <C-w>+
  nnoremap <silent><Left>  <C-w><
  nnoremap <silent><Right> <C-w>>
" ファイル操作
  nnoremap <Leader>w :<C-u>w<CR>
  nnoremap <Leader>Q :<C-u>q!<CR>
" ファイルエクスプローラー系
  nnoremap <silent><Leader><Leader>ex :<C-u>e .<CR>
  nnoremap <silent><Leader><Leader>sex :<C-u>Sex<CR>
" 置換操作
  nnoremap gs :<C-u>%s///g<Left><Left><Left>
  vnoremap gs :s///g<Left><Left><Left>
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
" キー入れ替え
  noremap ; :
  noremap : ;
" xとsの挙動
  nnoremap x "_x
  vnoremap x "_x
  nnoremap X "_X
  vnoremap X "_X
" vimgrep時の候補移動
  nnoremap <silent>[q :cprevious<CR>
  nnoremap <silent>]q :cnext<CR>
  nnoremap <silent>[Q :<C-u>cfirst<CR>
  nnoremap <silent>]Q :<C-u>clast<CR>
" .vimrcの再読み込み
  nnoremap <silent><Leader><Leader>so :<C-u>source ~/.config/nvim/init.vim<CR>
"文字コード変更して再読み込み
  nnoremap <silent> es :<C-u>e! ++enc=sjis<CR>
" コマンドライン設定
  cnoremap <C-a> <Home>
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>
  cnoremap <C-d> <Del>
  cnoremap <C-e> <End>
  cnoremap <C-n> <Down>
  cnoremap <C-p> <Up>
" control lの設定
  nnoremap <Leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" ctagsのタグジャンプ
  nnoremap <C-]> g<C-]>
" ターミナルモードの設定(nvim限定)
  if has('nvim')
    tnoremap <silent><C-[> <C-\><C-n>
  endif
"}}}

" ----------------------------------------
" Qfixhowmの設定
" ----------------------------------------
"{{{
  let QFixHowm_key = 'g'
  let howm_dir = '~/howm'
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
" deniteの設定
" ----------------------------------------
"{{{
  "call denite#custom#option('_', 'start_filter', v:true)
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
    nnoremap <silent><buffer><expr> <Tab> denite#do_map('choose_action')
    nnoremap <silent><buffer><expr> <C-g> denite#do_map('quit')
    nnoremap <silent><buffer><expr> i     denite#do_map('open_filter_buffer')
  endfunction
  nnoremap <silent> <C-k><C-f> :<C-u>Denite file/rec -start-filter<CR>
  nnoremap <silent> <C-k><C-g> :<C-u>Denite grep -start-filter<CR>
  nnoremap <silent> <C-k><C-l> :<C-u>Denite line -start-filter<CR>
  nnoremap <silent> <C-k><C-u> :<C-u>Denite file_mru -start-filter<CR>
  nnoremap <silent> <C-k><C-y> :<C-u>Denite neoyank -start-filter<CR>
  nnoremap <silent> <C-k><C-]> :<C-u>DeniteCursorWord grep -start-filter<CR>
"}}}

" ----------------------------------------
" vim easymotionの設定
" ----------------------------------------
"{{{
  map f <Plug>(easymotion-bd-fl)
  nmap s <Plug>(easymotion-s2)
  omap z <Plug>(easymotion-s2)
  vmap f <Plug>(easymotion-bd-f2)
  nmap <Leader>j <Plug>(easymotion-j)
  nmap <Leader>k <Plug>(easymotion-k)
  vmap <Leader>j <Plug>(easymotion-j)
  vmap <Leader>k <Plug>(easymotion-k)
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_startofline = 0
  let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
  let g:EasyMotion_use_upper = 1
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1
  let g:EasyMotion_use_migemo = 1
  nmap g/ <Plug>(easymotion-sn)
  xmap g/ <Plug>(easymotion-sn)
  omap g/ <Plug>(easymotion-tn)
  " nmap ww <Plug>(easymotion-w)
  nmap WW <Plug>(easymotion-bd-w)
"}}}

" ----------------------------------------
" HTML閉じタグ自動補完
" ----------------------------------------
"{{{
  augroup MyTag
    autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  augroup END
"}}}

" ----------------------------------------
" ----------------------------------------
" fzfの設定
" ----------------------------------------
"{{{
  nnoremap <silent>: <C-u>:Buffers<CR>
  nnoremap <silent>t <C-u>:Files<CR>
  "nnoremap <silent>r <C-u>:Tags<CR>
"}}}

" ----------------------------------------
"  色設定
" ----------------------------------------
"{{{
" カラースキーム決定
  set t_Co=256
  syntax enable
" カーソルライン設定
  set cursorline
  "augroup cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
"}}}

