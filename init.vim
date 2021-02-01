"  |    _)  _ \___  |_ |_ |
"  __ \  | |   |   /   |  |
"  | | | | |   |  /    |  |
" _| |_|_|\___/ _/    _| _|
" ----------------------------------------
" Start vim-plug settings
" ----------------------------------------
"{{{
call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'rking/ag.vim'
Plug 'cespare/vim-toml'
Plug 'cocopon/iceberg.vim'
Plug 'digitaltoad/vim-pug'
Plug 'posva/vim-vue'
Plug 'tpope/vim-markdown'
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
  let g:markdown_minlines = 100
Plug 'noahfrederick/vim-laravel'
Plug 'jwalton512/vim-blade'
Plug 'tmhedberg/matchit'
Plug 'itchyny/lightline.vim'
  let g:lightline = { 
  \   'colorscheme': 'wombat'
  \}
Plug 'vim-scripts/surround.vim'
Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '|'
Plug 'junegunn/vim-easy-align'
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'cocopon/vaffle.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'fuenor/JpFormat.vim'
  nnoremap gL :JpFormatAll!<CR>
Plug 'mattn/emmet-vim'
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,blade,markdown EmmetInstall
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let g:fzf_preview_window = ''
  let g:fzf_buffers_jump = 1
  let g:fzf_layout = { 'down': '40%' }
Plug 'terryma/vim-expand-region'
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
Plug 'neoclide/coc.nvim'
Plug 'tomtom/tcomment_vim'
  if !exists('g:tcomment_types')
    let g:tcomment_types = {}
  endif
  let g:tcomment_types['blade'] = '{{-- %s --}}'
  let g:tcomment_types['eruby'] = '<%# %s %>'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()
" colorsheme
if filereadable(expand("~/.config/nvim/plugged/iceberg.vim/colors/iceberg.vim"))
  colorscheme iceberg
endif
filetype plugin indent on
"}}}

" ----------------------------------------
"  Basic Settings
" ----------------------------------------
"{{{
nnoremap s <Nop>
nnoremap d <Nop>
nnoremap h <Nop>
nnoremap t <Nop>
nnoremap n <Nop>
nnoremap <Space> <Nop>
let mapleader="\<Space>"
let g:yankring_clipboard_monitor=0
set ambiwidth=double
set backspace=2
set clipboard=unnamed
set cmdheight=1
set diffopt=vertical
set display=lastline
set expandtab
set fdm=marker
set fencs=utf-8,sjis,euc-jp
set formatoptions+=t
set grepprg=rg\ --vimgrep\ --no-heading\ -i
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
set modeline
set modifiable
set nrformats-=octal
set nu
set pumheight=10
set ruler
set sh=bash
set shiftwidth=2
set shortmess+=c
set showcmd
set showmatch
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set so=7
set tabstop=2
set textwidth=0
set title
set tm=500
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
  autocmd BufWritePre *.html,*.css,*.scss,*.sass,*.less,*.php,*.rb,*.js,*.haml,*.erb,*.txt,*.ejs,*.jade,*.pug,*.ts call <SID>remove_dust()
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
    au BufRead,BufNewFile *.blade.php set filetype=blade
  augroup END
  augroup filetypeIndent
    au!
    au BufNewFile,BufRead *.scss set tabstop=4 shiftwidth=4
    au BufNewFile,BufRead *.php set tabstop=4 shiftwidth=4
    au BufNewFile,BufRead *.go set tabstop=4 shiftwidth=4 noexpandtab
    au BufNewFile,BufRead *.js set tabstop=4 shiftwidth=4
    au BufNewFile,BufRead *.vue set tabstop=2 shiftwidth=2
    au BufNewFile,BufRead *.json set tabstop=2 shiftwidth=2
    au BufNewFile,BufRead *.blade.php set tabstop=4 shiftwidth=4
  augroup END
  augroup diffWrap
    au!
    au FilterWritePre * if &diff | setlocal wrap | endif
  augroup END
"}}}

" ----------------------------------------
"  cocの設定
" ----------------------------------------
"{{{
  let g:coc_global_extentions = [
    \  'coc-lists'
    \, 'coc-json'
    \, 'coc-sh'
    \, 'coc-phpls'
    \, 'coc-html'
    \, 'coc-css'
    \, 'coc-tsserver'
    \, 'coc-solargraph'
    \, 'coc-docker'
    \]
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gfo <Plug>(coc-format)
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  " Hover表示
  nnoremap <silent> gh :<C-u>call CocAction('doHover')<CR>
  " function! s:show_documentation()
  "   if &filetype == 'vim'
  "     execute 'h '.expand('<cword>')
  "   else
  "     call CocAction('doHover')
  "   endif
  " endfunction
"}}}

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
  inoremap <silent><C-j> <ESC>
" カーソル操作
  inoremap <C-a> <Home>
  inoremap <C-e> <End>
  inoremap <C-f> <Right>
  inoremap <C-b> <Left>
" テキストオブジェクト操作
  " onoremap id i"
  " onoremap is i'
  " onoremap ia i>
  " onoremap ir i]
  " onoremap ib i)
" 移動を表示行単位に
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k
" 現在行を入れ替える
  nnoremap [.  :<C-u>execute 'move -1-'. v:count1<CR>
  nnoremap ].  :<C-u>execute 'move +'. v:count1<CR>
" 半ページ移動(中央維持
  " noremap H <C-u>zz
  " noremap L <C-d>zz
" insertモードで次の行に直接改行
  inoremap <C-o> <Esc>o
" cntrl + n キーで改行
  noremap <C-n> o<Esc>
" relativenumberのトグル
  nnoremap <Leader>nu :setlocal rnu!<CR>
" バッファの分割
  " noremap <silent><Leader><Leader>sp :<C-u>split<CR>
  " noremap <silent><Leader><Leader>vs :<C-u>vsplit<CR>
" カーソルキーでバッファのサイズ変更
  nnoremap <silent><Down>  <C-w>-
  nnoremap <silent><Up>    <C-w>+
  nnoremap <silent><Left>  <C-w><
  nnoremap <silent><Right> <C-w>>
" ファイル操作
  nnoremap <Leader>, :<C-u>w<CR>
  nnoremap <Leader>Q :<C-u>q!<CR>
" ファイルエクスプローラー系
  nnoremap <silent><Leader><Leader>ex :<C-u>e .<CR>
  nnoremap <silent><Leader><Leader>sex :<C-u>Sex<CR>
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
  nnoremap <silent><F6> :<C-u>source $MYVIMRC<CR>
"文字コード変更して再読み込み
  " nnoremap <silent> es :<C-u>e! ++enc=sjis<CR>
" コマンドライン設定
  cnoremap <C-a> <Home>
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>
  cnoremap <C-d> <Del>
  cnoremap <C-e> <End>
  cnoremap <C-n> <Down>
  cnoremap <C-p> <Up>
" control lの設定
  nnoremap <Leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" very nomagicの設定
  nnoremap / /\V
" ctagsのタグジャンプ
  nnoremap <C-]> g<C-]>
" screenコマンドとタグジャンプがバッティングするので変更
  nnoremap <silent><C-b> :<C-u>pop<CR>
" ターミナルモードの設定(nvim限定)
  if has('nvim')
    tnoremap <silent><C-[> <C-\><C-n>
  endif
" Visualモードでインデントした時の範囲解除を避ける
  vnoremap < <gv
  vnoremap > >gv
"}}}

" ----------------------------------------
"  vim easymotionの設定
" ----------------------------------------
"{{{
  map f <Plug>(easymotion-bd-fl)
  nmap s <Plug>(easymotion-s2)
  omap z <Plug>(easymotion-s2)
  vmap f <Plug>(easymotion-bd-f2)
  nmap <Leader>h <Plug>(easymotion-j)
  nmap <Leader>t <Plug>(easymotion-k)
  vmap <Leader>d <Plug>(easymotion-j)
  vmap <Leader>t <Plug>(easymotion-k)
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_startofline = 0
  let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
  let g:EasyMotion_use_upper = 1
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1
  let g:EasyMotion_use_migemo = 1
  nmap g\ <Plug>(easymotion-sn)
  xmap g\ <Plug>(easymotion-sn)
  omap g\ <Plug>(easymotion-tn)
  " nmap ww <Plug>(easymotion-w)
  " nmap WW <Plug>(easymotion-bd-w)
"}}}

" ----------------------------------------
"  HTML閉じタグ自動補完
" ----------------------------------------
"{{{
  augroup MyTag
    autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  augroup END
"}}}

" ----------------------------------------
"  fzfの設定
" ----------------------------------------
"{{{
  nnoremap <silent>: <C-u>:Buffers<CR>'
  nnoremap <silent>t <C-u>:Files<CR>
  nnoremap <silent>q: <C-u>:History:<CR>'
  nnoremap <silent><Leader>? <C-u>:GFiles?<CR>'
  nnoremap <silent><Leader>u <C-u>:GFiles<CR>'
  nnoremap <silent><Leader>d <C-u>:History<CR>'
  nnoremap <silent>r <C-u>:Tags<CR>
"}}}

" ----------------------------------------
"  set commands
" ----------------------------------------
"{{{
" 現在開いているファイルのディレクトリに移動(バッファ限定)
  function SetLcd()
    lcd %:h
  endfunction
  command! -nargs=0 Lcd :call SetLcd()
" Rename {新しいファイル名}
  command! -nargs=1 -complete=file Rename file <args> | call delete(expand('#'))
" CocList grepを実行する
  function CocGrep()
    CocList grep
  endfunction
  command! -nargs=0 Grep :call CocGrep()
  nnoremap <ESC><ESC>g <C-u>:Grep<CR>
" terminalを分割して開く
  if (has('nvim'))
    command! -nargs=* Term split | terminal <args>
  endif
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
  augroup cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
  hi clear Visual
  hi Visual ctermfg=255 ctermbg=240 guifg=#eff0f4 guibg=#5b6389
"}}}

" Dovorak 設定
"{{{
  nnoremap H J
  nnoremap J E
  nnoremap K B
  nnoremap d h
  nnoremap e d
  nnoremap ee dd
  nnoremap gh j
  nnoremap gt k
  nnoremap h gj
  nnoremap j e
  nnoremap k b
  nnoremap n l
  nnoremap t gk

  vnoremap H J
  vnoremap J E
  vnoremap K B
  vnoremap d h
  vnoremap e d
  vnoremap h gj
  vnoremap j e
  vnoremap k b
  vnoremap n l
  vnoremap t gk

  nnoremap r n
  nnoremap R N
  nnoremap zh zj
  nnoremap zt zk
"}}}

" vim: set ts=2 sw=2 :
