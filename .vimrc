set ruler
set nu

set encoding=utf-8
set fenc=utf-8

set backspace=2

set list
set listchars=tab:»-,trail:-,eol:↲,extends:>,precedes:<,nbsp:%

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

if !exists('g:markrement_char')
   let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
  endif
  nnoremap <silent>m :<C-u>call <SID>AutoMarkrement()<CR>
  function! s:AutoMarkrement()
      if !exists('b:markrement_pos')
          let b:markrement_pos = 0
      else
          let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
      endif
      execute 'mark' g:markrement_char[b:markrement_pos]
      echo 'marked' g:markrement_char[b:markrement_pos]
  endfunction

autocmd BufReadPost * delmarks!

set nocompatible
filetype plugin indent off

if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

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

": と ; 入れ替え
noremap ; :
noremap : ;

" insertモードから抜ける
inoremap <silent> <C-k><C-k> <ESC>

" カーソル操作
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-f> <Right>
noremap! <C-b> <Left>

" カーソルライン設定
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
hi clear CursorLine
hi CursorLine gui=underline
highlight Cursorline ctermbg=black guibg=white

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
  let g:neocomplete#enable_at_startup = 1
  " 候補1番目を選択状態でポップアップ
  let g:neocomplete#enable_auto_select = 1
  " Ctrl+Space で 補完ON
  inoremap <expr><C-Space> pumvisible() ? "\<down>" : neocomplete#start_manual_complete()
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#enable_smart_case = 1

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

colorscheme Tomorrow-Night-Blue

syntax on
