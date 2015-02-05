set t_Co=256
set ruler
set nu
set backspace=2
set list
set listchars=tab:»-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%
set showcmd
set nowrap
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
set ignorecase
set smartcase
set incsearch
set wrapscan
set clipboard=unnamed,autoselect
set laststatus=2

filetype plugin indent off

" カーソルライン設定
  set cursorline
  augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
  augroup END
  hi clear CursorLine
  hi CursorLine gui=underline
  highlight Cursorline ctermbg=white guibg=white

" 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge

" 全角スペースの設定
  function! ZenkakuSpace()
      highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
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
  set encoding=utf8
  set fileencodings=iso-2022-jp,sjis,utf8
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
  inoremap <silent> <C-k><C-k> <ESC>
" カーソル操作
  noremap! <C-a> <Home>
  noremap! <C-e> <End>
  noremap! <C-f> <Right>
  noremap! <C-b> <Left>
  inoremap <> <><LEFT>
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
  inoremap ～ ~
" キー入れ替え
  noremap ; :
  noremap : ;

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

" neosnippetプラグイン
  NeoBundle 'Shougo/neosnippet.vim'

" neocompleteプラグイン
  NeoBundle 'Shougo/neocomplete'
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
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

" evervimプラグイン
  NeoBundle 'kakkyz81/evervim'
  let g:evervim_devtoken='S=s399:U=4676794:E=14dc6c37749:C=1466f124b4e:P=1cd:A=en-devtoken:V=2:H=ea3cbce5d9944497b6e6f7f05014b611'
  let g:evervim_splitoption=''

" open-brouwserプラグイン
  NeoBundle 'tyru/open-browser.vim'

" emmetプラグイン
  NeoBundle 'mattn/emmet-vim'

" NERDTreeプラグイン
  NeoBundle 'scrooloose/nerdtree'
  nnoremap <C-e>e :NERDTreeToggle<CR>
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

" solarized カラースキーム
  NeoBundle 'altercation/vim-colors-solarized'
" mustang カラースキーム
  NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
  NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
  NeoBundle 'nanotech/jellybeans.vim'
    let g:jellybeans_overrides = {
    \    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
    \              'ctermfg': 'Black', 'ctermbg': 'Yellow',
    \              'attr': 'bold' },
    \}
" lucius カラースキーム
  NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
  NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
  NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
  NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
  NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
  NeoBundle 'tomasr/molokai'
" pyte カラースキーム
  NeoBundle 'therubymug/vim-pyte'
" phd カラースキーム
  NeoBundle 'vim-scripts/phd'
" tomorrow カラースキーム
  NeoBundle 'chriskempson/vim-tomorrow-theme'

" カラースキーム一覧表示に Unite.vim を使う
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'ujihisa/unite-colorscheme'

" tlibプラグイン
  NeoBundle 'tomtom/tlib_vim'
" ttocプラグイン
  NeoBundle 'tomtom/ttoc_vim'

" unite-outlineプラグイン
  NeoBundle 'h1mesuke/unite-outline'

" autocloseプラグイン
  NeoBundle 'Townk/vim-autoclose'

" vim-matchitプラグイン
  NeoBundle 'tmhedberg/matchit'

call neobundle#end()

" Required:
 filetype plugin indent on


NeoBundleCheck
" ----------------------------------------
" End NeoBundle Settings
" ----------------------------------------

colorscheme jellybeans

syntax on
