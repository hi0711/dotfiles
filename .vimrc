"      ＿     ＿    ＿    ＿＿＿    ＿＿＿    ＿    ＿
"    /  /   /  /  /  /  / ＿   / /＿＿   /  /  /  /  /
"   /   ---   /  /  /  / /  / /      /  /  /  /  /  /
"  /   ---   /  /  /  / /＿/ /      /  /  /  /  /  /
" /＿/   /＿/  /＿/  /＿＿＿/      /＿/  /＿/  /＿/

" ----------------------------------------
" Start NeoBundle Settings
" ----------------------------------------
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
" evervimプラグイン
  NeoBundle 'kakkyz81/evervim'
  let g:evervim_devtoken='S=s399:U=4676794:E=14dc6c37749:C=1466f124b4e:P=1cd:A=en-devtoken:V=2:H=ea3cbce5d9944497b6e6f7f05014b611'
  let g:evervim_splitoption=''
" open-browserプラグイン
  NeoBundle 'tyru/open-browser.vim'
" ctrlpプラグイン
  NeoBundle 'kien/ctrlp.vim'
" emmetプラグイン
  NeoBundle 'mattn/emmet-vim'
  let g:user_emmet_leader_key='em'
" NERDTreeプラグイン
  NeoBundle 'scrooloose/nerdtree'
  nnoremap <C-e> :NERDTreeToggle<CR>
  let NERDTreeShowHidden = 1
  autocmd vimenter * if !argc() | NERDTree | endif
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
" tlibプラグイン
  NeoBundle 'tomtom/tlib_vim'
" ttocプラグイン
  NeoBundle 'tomtom/ttoc_vim'
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
" molokai カラースキーム
  NeoBundle 'tomasr/molokai'
call neobundle#end()
" Required:
 filetype plugin indent on
NeoBundleCheck

" ----------------------------------------
"  Basic Settings
" ----------------------------------------
let mapleader=","
set ruler
set nu
set backspace=2
set list
set listchars=tab:»-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%
set showcmd
set wrap
set display=lastline
set textwidth=0
set nowritebackup
set nobackup
set noswapfile
set title
set showmatch
set matchtime=1
set tabstop=2
set shiftwidth=2
set smartindent
set expandtab
set fdm=manual
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
  autocmd BufWritePre * call <SID>remove_dust()
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
"ステータスラインに文字コードと改行文字を表示する
  function! CharCount ()
    if exists('b:charCounterCount')
      return b:charCounterCount
    else
      return 0
    endif
  endfunc
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
  " □とか○の文字があってもカーソル位置がずれないようにする
  if exists('&ambiwidth')
    set ambiwidth=double
  endif
" undo記憶、undoファイルの生成
  if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
  endif
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

" ----------------------------------------
"  キーマッピング設定
" ----------------------------------------
" Yを行末までのヤンクにする
  nnoremap Y y$
" スペースキー + . で.vimrcを開く
  nnoremap <Space>. :<C-u>tabedit ~/.vimrc<CR>
" 検索語が画面の真ん中に来るようにする
  nmap n nzz
  nmap N Nzz
  nmap * *zz
  nmap # #zz
  nmap g* g*zz
  nmap g# g#zz
" insertモードから抜ける
  inoremap jj <ESC>:up<CR>
  inoremap <C-j> j
" カーソル操作
  noremap! <C-a> <Home>
  noremap! <C-e> <End>
  noremap! <C-f> <Right>
  noremap! <C-b> <Left>
  inoremap "" ""<LEFT>
  inoremap '' ''<LEFT>
  inoremap <> <><LEFT>
  inoremap [] []<LEFT>
  inoremap {} {}<LEFT>
" スペースキーを押した時、中心を保ってスクロール
  nnoremap <Space> jzz
  nnoremap <S-Space> kzz
" 中央を維持しながら移動
  noremap j gjzz
  noremap k gkzz
  noremap gj j
  noremap gk k
  noremap G Gzz
  noremap gg ggzz
  noremap <C-d> <C-d>zz
  noremap <C-u> <C-u>zz
" insertモードで次の行に直接改行
  inoremap <C-o> <Esc>o
" cntrl + n キーで改行
  noremap <C-n> o<Esc>
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
" タブ操作
  nnoremap <Leader>tab :<C-u>tabe<CR>
  nnoremap <Leader>tn gt
  nnoremap <Leader>tp gT
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
  map  bh <C-w>h
  map  bl <C-w>l
  map  bj <C-w>j
  map  bk <C-w>k
  map gl :macaction selectNextWindow:<CR>
  map gh :macaction selectPreviousWindow:<CR>
" キー入れ替え
  noremap ; :
  noremap : ;
" vimgrep時の候補移動
  nnoremap [q :cprevious<CR>   " 前へ
  nnoremap ]q :cnext<CR>       " 次へ
  nnoremap [Q :<C-u>cfirst<CR> " 最初へ
  nnoremap ]Q :<C-u>clast<CR>  " 最後へ
" hlsearchの解除
  nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" .vimrcの再読み込み
  nnoremap <Leader>source :<C-u>source ~/.vimrc<CR>
"文字コード変更して再読み込み
  nnoremap <silent> eu :<C-u>e ++enc=utf-8<CR>
" 日付の挿入
  inoremap <Leader>date <C-R>=strftime('%Y/%m/%d')<CR>
  inoremap <Leader>time <C-R>=strftime('%H:%M:%S')<CR>
  inoremap <Leader>datetime <C-R>=strftime('%Y-%m-%d_%H%M%S')<CR>
  inoremap <Leader>w3cd <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" ----------------------------------------
" HTML閉じタグ自動補完
" ----------------------------------------
augroup MyTag
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

" ----------------------------------------
"  色設定
" ----------------------------------------
" カラースキーム決定
  set t_Co=256
  syntax enable
  colorscheme molokai
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
