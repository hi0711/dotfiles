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
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
  let g:markdown_minlines = 100
Plug 'noahfrederick/vim-laravel', { 'for': 'php' }
Plug 'jwalton512/vim-blade', { 'for': 'php' }
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
  autocmd FileType html,css,php,markdown,javascript EmmetInstall
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
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'haya14busa/vim-migemo'
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
  let g:elm_setup_keybindings = 0
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript','typescript.tsx']}
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tyru/columnskip.vim'
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
  set hidden
  set history=1000
  set hlsearch
  set ignorecase
  set incsearch
  set inccommand=split
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
  " ripgrep
    if executable('rg')
      set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
      set grepformat=%f:%l:%c:%m
    endif
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
          au!
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
"  cocの設定
" ----------------------------------------
"{{{
  let g:coc_global_extensions = [
    \  'coc-lists'
    \, 'coc-json'
    \, 'coc-sh'
    \, 'coc-phpls'
    \, 'coc-html'
    \, 'coc-css'
    \, 'coc-tsserver'
    \, 'coc-solargraph'
    \, 'coc-docker'
    \, 'coc-word'
    \, 'coc-tabnine'
    \, 'coc-pairs'
    \, 'coc-styled-components'
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
  nnoremap <silent> gf :<C-u>call CocAction('doHover')<CR>
  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  " coc-pairsの設定
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"}}}

" ----------------------------------------
"  キーマッピング設定
" ----------------------------------------
"{{{
" Yを行末までのヤンクにする
  nnoremap Y y$
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
  nnoremap <Leader><silent>c :call cursor(0,strlen(getline("."))/2)<CR>
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
  " nnoremap <silent> <Leader>ta :<C-u>tabe<CR>
  " nnoremap <silent> <Leader>tn gt
  " nnoremap <silent> <Leader>tp gT
  " nnoremap <silent> <Leader>tc :<C-u>tabc<CR>
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
  cnoremap <C-h> <BackSpace>
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
" cwin操作
  nnoremap <silent><Leader>op :<C-u>copen<CR>
  nnoremap <silent><Leader>cl :<C-u>cclose<CR>
"}}}

" ----------------------------------------
"  filetype settings
" ----------------------------------------
"{{{
  augroup filetypeSet
    au!
    au BufRead,BufNewFile,BufEnter *.ejs set filetype=html
    au BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    au BufLeave *.{js,jsx,ts,tsx} :syntax sync clear   
  augroup END
  augroup filetypeIndent
    au!
    au BufNewFile,BufRead,BufEnter *.php setlocal tabstop=4 shiftwidth=4
    au BufNewFile,BufRead,BufEnter *.go setlocal tabstop=4 shiftwidth=4 noexpandtab
    au BufNewFile,BufRead,BufEnter *.{js,jsx,ts,tsx} setlocal tabstop=2 shiftwidth=2
    au BufNewFile,BufRead,BufEnter *.blade.php setlocal tabstop=4 shiftwidth=4
  augroup END
  augroup diffWrap
    au!
    au FilterWritePre * if &diff | setlocal wrap | endif
  augroup END
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
  vmap <Leader>h <Plug>(easymotion-j)
  vmap <Leader>t <Plug>(easymotion-k)
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_startofline = 0
  let g:EasyMotion_keys = 'AOEUIDHTNS-,.PYFGCRL;QJKXBMWVZ'
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
"  vim-surroundの設定
" ----------------------------------------
"{{{
  let g:surround_no_mappings = 1
  nmap es  <Plug>Dsurround
  nmap cs  <Plug>Csurround
  nmap ys  <Plug>Ysurround
  nmap yS  <Plug>YSurround
  nmap yss <Plug>Yssurround
  nmap ySs <Plug>YSsurround
  nmap ySS <Plug>YSsurround
  xmap S   <Plug>VSurround
  xmap gS  <Plug>VgSurround
  if !exists("g:surround_no_insert_mappings") || ! g:surround_no_insert_mappings
    if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
      imap    <C-S> <Plug>Isurround
    endif
    imap      <C-G>s <Plug>Isurround
    imap      <C-G>S <Plug>ISurround
  endif
"}}}

" ----------------------------------------
"  fzfの設定
" ----------------------------------------
"{{{
  nnoremap <silent>: <C-u>:Buffers<CR>'
  nnoremap <silent>q: <C-u>:History:<CR>'
  nnoremap <silent><Leader>? <C-u>:GFiles?<CR>'
  nnoremap <silent><Leader>u <C-u>:GFiles<CR>'
  nnoremap <silent><Leader>d <C-u>:History<CR>'
  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line) 
  nnoremap <silent>r <C-u>:Tags<CR>
"}}}

" ----------------------------------------
"  columnskipの設定
" ----------------------------------------
"{{{
  nmap <silent>\h <Plug>(columnskip:nonblank:next)
  omap <silent>\h <Plug>(columnskip:nonblank:next)
  xmap <silent>\h <Plug>(columnskip:nonblank:next)
  nmap <silent>\t <Plug>(columnskip:nonblank:prev)
  omap <silent>\t <Plug>(columnskip:nonblank:prev)
  xmap <silent>\t <Plug>(columnskip:nonblank:prev)
"}}}

" ----------------------------------------
"  js関連の設定
" ----------------------------------------
"{{{
function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction

augroup MyVimrc
  au!
augroup END

autocmd MyVimrc FileType javascript,javascript.jsx call EnableJavascript()
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
" git blameコマンド実行
  function Gblame()
    Git blame
  endfunction
  command! Gblame :call Gblame()
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
    au!
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
  nnoremap e d
  nnoremap E D
  nnoremap ee dd
  nnoremap j e
  nnoremap k b
  nnoremap l <Nop>

  au Filetype * nnoremap <silent><nowait>d h
  au Filetype * nnoremap <silent><nowait>gh j
  au Filetype * nnoremap <silent><nowait>h gj
  au Filetype * nnoremap <silent><nowait>gt k
  au Filetype * nnoremap <silent><nowait>t gk
  au Filetype * nnoremap <silent><nowait>n l

  vnoremap H J
  vnoremap J E
  vnoremap K B
  vnoremap e d
  vnoremap j e
  vnoremap k b
  vnoremap l <Nop>

  au Filetype * vnoremap <silent><nowait>d h
  au Filetype * vnoremap <silent><nowait>gh j
  au Filetype * vnoremap <silent><nowait>h gj
  au Filetype * vnoremap <silent><nowait>gt k
  au Filetype * vnoremap <silent><nowait>t gk
  au Filetype * vnoremap <silent><nowait>n l

  nnoremap r n
  nnoremap R N
  nnoremap zh zj
  nnoremap zt zk
"}}}

" vim: set ts=2 sw=2 :
