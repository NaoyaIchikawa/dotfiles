" 一般設定====================================================================================
" vi 互換ではなくVim のデフォルト設定にする
set nocompatible
set t_Co=256
set statusline=[ro:%r][mdfyd:%m]\ \[encd:%{&fileencoding}][fileTyp:%{&filetype}]%F%=[%l-%c]%7{b:charCounterCount}/%L\ \%4p%%
"バックアップは上書きに成功した後に削除される。
set nowritebackup
" OSのクリップボードを使う
"set clipboard+=unnamed
set clipboard=unnamed,autoselect
" set clipboard=unnamed
set mouse=a

" 更新時自動再読込み
set autoread
" スワップファイルを作らない
set noswapfile


" コマンド補完を強化
set wildmenu
" リスト表示，最長マッチ
set wildmode=list:full

" ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" 不可視文字を表示
"タブ			
"半角sp 
"全角sp　
"改行
" set list
" set listchars=tab:>-,trail:-
" 対応括弧をハイライト表示する
set showmatch
" 文字がない場所にもカーソルを移動できるようにする
" set virtualedit=all
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap &lt;Tab&gt; %
vnoremap &lt;Tab&gt; %

" set cursorline
"タブ幅の設定
set tabstop=2
set expandtab
set shiftwidth=2
"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
"バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
"□や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
"コマンドライン補完するときに強化されたものを使う
set wildmenu
" シンタックスハイライト
syntax on
" スクロールする時に下が見えるようにする
set scrolloff=3
" 右下に表示される行・列の番号を表示する
set ruler

"検索の時に大文字小文字を区別しない
"ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
"検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
"インクリメンタルサーチ
set incsearch
"検索文字の強調表示
set hlsearch

"エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
"マクロ実行中などの画面再描画を行わない
"set lazyredraw
"Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
"行番号表示
set number
"括弧の対応表示時間
set showmatch matchtime=1
"タブを設定
"set ts=4 sw=4 sts=4
"自動的にインデントする
"set autoindent
"Cインデントの設定
"set cinoptions+=:0
"タイトルを表示
set title
"コマンドラインの高さ (gvimはgvimrcで指定)
set cmdheight=2
set laststatus=2
"コマンドをステータス行に表示
set showcmd
"画面最後の行をできる限り表示する
set display=lastline
" Ctrl+dで$、Ctrl+aで@
inoremap <C-d> $
inoremap <C-a> @

"閉じ括弧が入力されたとき、対応する括弧を表示する。
set sm
"新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする
set ai

filetype off


" 一般設定====================================================================================
 
" 組み込み関数================================================================================
" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif
 
    if a:bang == ''
        pwd
    endif
endfunction

augroup CharCounter
    autocmd!
    autocmd BufNew,BufEnter,BufWrite,InsertLeave * call <SID>Update()
augroup END

function! s:Update()
	let b:charCounterCount = s:CharCount()
endfunction

function! s:CharCount()
   	    let l:result = 0
		    for l:linenum in range(0, line('$'))
   		        let l:line = getline(l:linenum)
   		        let l:result += strlen(substitute(l:line, ".", "x", "g"))
   		    endfor
   		    return l:result
endfunction
" 文字コードの自動判定

"行頭のスペースの連続をハイライトさせる
"Tab文字も区別されずにハイライトされるので、区別したいときはTab文字の表示を別に
"設定する必要がある。
function! SOLSpaceHilight()
    syntax match SOLSpace "^\s\+" display containedin=ALL
    highlight SOLSpace term=underline ctermbg=LightGray
endf


" 組み込み関数================================================================================
" プラグイン==================================================================================
set rtp+=~/.vim/vundle.git/
call vundle#rc()
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
	endif
	" originalrepos on github
	NeoBundle 'Shougo/neobundle.vim'
	NeoBundle 'Shougo/vimproc'
	NeoBundle 'VimClojure'
	NeoBundle 'Shougo/vimshell'
	NeoBundle 'Shougo/unite.vim'
  NeoBundle 'nathanaelkane/vim-indent-guides'
	NeoBundle 'Shougo/neosnippet'
	NeoBundle 'jpalardy/vim-slime'
	NeoBundle 'scrooloose/syntastic'
	NeoBundle 'derekwyatt/vim-scala'
	NeoBundle "tyru/caw.vim.git"
	NeoBundle 'tomasr/molokai.git'
	NeoBundle 'altercation/vim-colors-solarized'
	NeoBundle 'jonathanfilip/vim-lucius'
	NeoBundle 'vim-scripts/Wombat'
	NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'Shougo/neosnippet-snippets'
	NeoBundle 'tpope/vim-surround'
	NeoBundle 'vim-scripts/taglist.vim'
	NeoBundle 'chrisbra/csv.vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'yegappan/mru'
  NeoBundle 'gregsexton/MatchTag'
  NeoBundle 'rhysd/vim-clang-format'
  NeoBundle 'vim-startify'
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'vim-scripts/dbext.vim'
  NeoBundle 'mattn/vdbi-vim'
  NeoBundle 'mattn/webapi-vim'
  NeoBundle 'basyura/unite-rails'
  NeoBundle 'toyamarinyon/vim-swift'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'goldfeld/vim-seek'
  NeoBundle 'szw/vim-tags'
  NeoBundle 'Align'

filetype plugin indent on     " required!
filetype indent on


" コメントアウト／コメントイン切り替え
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" vim-tags
nnoremap <C-]> g<C-]>

autocmd ColorScheme * highlight Comment ctermfg=247 guifg=#008800
colorscheme molokai
let g:molokai_original=1


let g:quickrun_config={'*': {'split': ''}}
set splitbelow
" let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
" nnoremap <leader>r :QuickRun -cmdopt "<CR>
" nnoremap <leader>R :QuickRun <CR>

nnoremap <leader>R :QuickRun -cmdopt "<CR>
nnoremap <leader>r :QuickRun <CR>
" syntacticChek用
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2


"tag List
set tags=tags
" ctagsのコマンド
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" 現在表示中のファイルのみのタグしか表示しない
let Tlist_Show_One_File = 1
" 右側にtag listのウインドうを表示する
let Tlist_Use_Right_Window = 1
" taglistのウインドウだけならVimを閉じる
let Tlist_Exit_OnlyWindow = 1
" \lでtaglistウインドウを開いたり閉じたり出来るショートカット
map <silent> <leader>t :TlistToggle<CR>
		
map <leader>l :Tlist<CR>

" インデントに色を付けて見やすくする
 " vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
" let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1

" NERDTREE
let g:indent_guides_guide_size=1" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
nnoremap <leader>n :NERDTree<CR>
" デフォルトでツリーを表示させる
" autocmd VimEnter * execute 'NERDTree'

" MRU(最近開いたファイルの履歴を表示する)
nnoremap <leader>m :MRU<CR>

" プラグイン==================================================================================
"コピペで貼り付けたときずれないように
set paste
set clipboard+=autoselect      " visual selection -> clipboard
set clipboard+=unnamed         " yank -> clipboard

set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
" エンコード
set encoding=utf8
"

" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=green guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=green guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')



" JSONビューワ
command! -nargs=? Json call s:Json(<f-args>)
function! s:Json(...)
  execute  "%!python -m json.tool;"
endfunction

"C-cでESC
inoremap <C-c> <ESC>

" set number
function Setnumber()
  if &number
    setlocal nonumber
  else
    setlocal number
  endif
endfunction
nnoremap <silent> <C-n> :call Setnumber()<CR>

" " set paste
" function Setpaste()
"   if &paste
"   else
"     setlocal paste
"   endif
" endfunction
" nnoremap <silent> <C-p> :call Setpaste()<CR>



NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kannokanno/previm'
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" Previm
let g:previm_open_cmd = ''
nmap <leader>a :<C-u>PrevimOpen<CR>
" nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
" nnoremap <silent> [previm]r :call previm#refresh()<CR>

" タブ切り替え
" nnoremap <C-t>  :tabnew<CR>
" nnoremap <C-w>  :tabclose<CR>
nnoremap tt   gt
nnoremap TT gT


" スワップファイルが存在する場合リードオンリーで開く
augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END





"ndtab  改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set autoindent
set smartindent

nnoremap <leader>q :reg<CR>

" Yを、行末までのヤンクにする
nnoremap Y y$

" 補完メニューの高さを変更
set pumheight=10


set paste
" vimの自動読み込み頻度を向上させる
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END


" startify
let g:startify_bookmarks = [
  \ '~/.bashrc',
  \ '~/.vimrc',
  \ ]


" 連番置き換え
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let snf=&nf|set nf-=octal|let cl = col('.')|for nc in range(1, <count>?<count>-line('.'):1)|exe 'normal! j' . nc . <q-args>|call cursor('.', cl)|endfor|unlet cl|unlet snf

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
