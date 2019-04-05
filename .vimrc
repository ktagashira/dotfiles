"""""""""""""""""""""""""""""
" dein.vimのセットアップ
"""""""""""""""""""""""""""""

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimがなければclone
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:config_dir  = expand('~/.vim')
  let s:toml        = g:config_dir . '/plugins.toml'
  let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  " カラースキーム追加
  call dein#add('tomasr/molokai')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
	call dein#install()
endif

"""""""""
"""""""""

" タブ関連
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
" インデント
set autoindent
" 入力補助系
"inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
set backspace=indent,eol,start
" 行番号表示
set number
" カラースキーマ
set background=dark
colorscheme molokai

syntax on

" 表示系
set cursorline


" カーソル位置
set ruler

" 検索系
set incsearch
" 挿入からノーマルへ(ESC)
inoremap <C-j> <Esc>

let g:loadedInsertTag = 1
inoremap <C-c> <Esc>:call InsertClosingTag()<CR>i

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
