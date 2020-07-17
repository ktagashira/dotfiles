if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'tomasr/molokai'
Plug 'Shougo/neocomplete.vim'
Plug 'pangloss/vim-javascript'

" markdown
"Plug 'plasticboy/vim-markdown'
"Plug 'suan/vim-instant-markdown'
", { 'for': 'markdown'}

" TSX
"Plug 'clausreinke/typescript-tools.vim'
", { 'do': 'npm install' }
"Plug 'clausreinke/typescript-tools'
"
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'alvan/vim-closetag'

"Plug 'yuezk/vim-js'
"Plug 'MaxMEllon/vim-jsx-pretty'

call plug#end()

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

autocmd ColorScheme * hi tsxTagName ctermfg=9

" orange
"autocmd ColorScheme * hi tsxCloseString ctermfg=202
autocmd ColorScheme * hi tsxCloseTag ctermfg=118
autocmd ColorScheme * hi tsxCloseTagName ctermfg=202
autocmd ColorScheme * hi tsxAttributeBraces ctermfg=118
autocmd ColorScheme * hi tsxEqual ctermfg=202

" yellow
"autocmd ColorScheme * hi tsxAttrib ctermfg=208 cterm=italic

" light-grey
autocmd ColorScheme * hi tsxTypeBraces ctermfg=247
" dark-grey
autocmd ColorScheme * hi tsxTypes ctermfg=237

autocmd ColorScheme * hi ReactState ctermfg=92
autocmd ColorScheme * hi ReactProps ctermfg=138
autocmd ColorScheme * hi ApolloGraphQL ctermfg=131
autocmd ColorScheme * hi Events ctermfg=204 
autocmd ColorScheme * hi ReduxKeywords ctermfg=204 
autocmd ColorScheme * hi ReduxHooksKeywords ctermfg=204 
autocmd ColorScheme * hi WebBrowser ctermfg=204 
autocmd ColorScheme * hi ReactLifeCycleMethods ctermfg=204 

" カラースキーマ
"set background=dark
colorscheme molokai

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
set fileencodings=utf-8
set fileformats=unix,dos,mac

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint','tslint']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nnoremap <C-C> :w<CR>:SyntasticCheck<CR>

" neocomplete
" highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
set completeopt=menuone

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

let g:instant_markdown_autostart=1
set shell=bash\ -i

" 自動閉じタグ設定
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.tsx,*jsx"

" vim-sx-script 設定
" jsx含める
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx


filetype plugin on
syntax enable
syntax on

set laststatus=2
set statusline=%y

" カーソル下のhighlight情報を表示する {{{
function! s:get_syn_id(transparent)
    let synid = synID(line('.'), col('.'), 1)
    return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
    return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
    execute "highlight " . s:get_syn_name(s:get_syn_id(0))
    execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HInfo call s:get_highlight_info()

