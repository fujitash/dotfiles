" Status
set backspace=start,eol,indent
set whichwrap=b,s,[,],,~
set number
set listchars=tab:>-,trail:-,extends:<,precedes:>,nbsp:%
set list

set statusline=%F%m%r%h%w\ [FORMAT=%{&fileencoding}\ %{&fileformat}]
set laststatus=2
set wildmenu

" ##################################################
" Encoding
set termencoding=UTF-8
set encoding=japan
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fenc=UTF-8
set enc=UTF-8

" ##################################################
" Search
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch

" ##################################################
" 暗い背景色に合わせた配色にする
" カラースキーマの指定
"
" set term=builtin_linux
" set ttytype=builtin_linux
set t_Co=256
set syntax=htmldjango
syntax on

" 行番号の色
highlight LineNr ctermfg=darkyellow
" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" カレント行ハイライトON
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE

" ##################################################
" Tab
set tabstop=2 shiftwidth=2
set expandtab

" ##################################################
" HTML php tpl js css 編集時はタブ幅を4に設定
autocmd FileType html,php,tpl,js,css set tabstop=4 shiftwidth=4

" ##################################################
" Indent
set autoindent
set cindent

"##################################################
" CSVハイライト関数
function! CSVH(x)
  let col = a:x-1
  execute 'match Keyword /^\([^,]*,\)\{'.l:col.'}\zs[^,]*/'
  execute 'normal ^'.l:col.'f,'
endfunction
command! -nargs=1 Csvhl :call CSVH(<args>)

" ##################################################
" Key maapping

" ESC → Control-j
inoremap jk <esc>

" Tab
nmap <S-t> :tabnew<RETURN>
nmap <S-l> :tabnext<RETURN>
nmap <S-h> :tabprevious<RETURN>

" Reload .vimrc
nmap <Space>r :source $HOME/.vimrc<RETURN>

" Move Split Window
nmap <Space>h <C-w>h
nmap <Space>j <C-w>j
nmap <Space>k <C-w>k
nmap <Space>l <C-w>l

" Open Split Window in New Tab
"nmap <Space>t <C-w>T

nmap <ESC><ESC><ESC> :noh<RETURN>

" autoclose
inoremap (<CR> ()<Left>
inoremap '<CR> ''<Left>
inoremap "<CR> ""<Left>
inoremap [<CR> []<Left>
inoremap {<CR> {}<Left>
inoremap <<CR> <><Left>



" ##################################################
"NEOBUNDLEプラグイン
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'
" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
" Ruby向けにendを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'
" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'
" QuickRun"
NeoBundle 'thinca/vim-quickrun'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" ##################################################
"NEOBUNDLEプラグイン詳細設定
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" " デフォルトでツリーを表示させる
" autocmd VimEnter * execute 'NERDTree'
"QuickRun設定"
let g:quickrun_config={'*': {'split': ''}}
set splitbelow
set filetype=ruby

"ファイル表示
" 入力モードで開始する
"let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key
"
