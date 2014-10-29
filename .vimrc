" vi 互換ではなくVim のデフォルト設定にする
set nocompatible
set t_Co=256
set statusline=[ro:%r][mdfyd:%m]\ \[encd:%{&fileencoding}][fileTyp:%{&filetype}]%F%=[%l-%c]%7{b:charCounterCount}/%L\ \%4p%%
"highlight statusline   term=NONE cterm=NONE guifg=red ctermfg=green ctermbg=get_color(78)
"バックアップは上書きに成功した後に削除される。
set nowritebackup
" OSのクリップボードを使う
"set clipboard+=unnamed
set clipboard=unnamed

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
" set listchars=tab:>-,eol:_,trail:-
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
" ハイライトを有効にする
syntax on
" Ctrl+dで$、Ctrl+aで@
inoremap <C-d> $
inoremap <C-a> @

set sm
set ai

filetype off
 
set rtp+=~/.vim/vundle.git/
call vundle#rc()

""""""""""""""""""""""""""""""
"全角スペースを表示 　	
"
""""""""""""""""""""""""""""""
"コメント以外で全角スペースを指定しているので、scriptencodingと、
"このファイルのエンコードが一致するよう注意！
"強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
"scriptencoding cp932

"デフォルトのZenkakuSpaceを定義
" function! ZenkakuSpace()
  " highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
" endfunction

" if has('syntax')
"   augroup ZenkakuSpace
"     autocmd!
"     " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
"     autocmd ColorScheme       * call ZenkakuSpace()
"     " 全角スペースのハイライト指定
"     autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"   augroup END
"   call ZenkakuSpace()
" endif
" " :e などでファイルを開く際にフォルダが存在しない場合は自動作成
" function! s:mkdir(dir, force)
"   if !isdirectory(a:dir) && (a:force ||
"         \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
"     call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
"   endif
" endfunction
" 
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

	NeoBundle 'Shougo/neosnippet'
	NeoBundle 'jpalardy/vim-slime'
	NeoBundle 'scrooloose/syntastic'
	NeoBundle 'derekwyatt/vim-scala'
	NeoBundle 'Shougo/neocomplete'
	NeoBundle "tyru/caw.vim.git"
	NeoBundle 'tomasr/molokai.git'
	NeoBundle 'altercation/vim-colors-solarized'
	NeoBundle 'jonathanfilip/vim-lucius'
	NeoBundle 'vim-scripts/Wombat'
	NeoBundle 'rking/ag.vim'
	NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'Shougo/neosnippet-snippets'
	NeoBundle 'tpope/vim-surround' 
	NeoBundle 'vim-scripts/taglist.vim' 
	NeoBundle 'chrisbra/csv.vim' 
	" NeoBundle 'rainbow_csv.vim' 
  " NeoBundle 'rbtnn/rabbit-ui.vim'
  " NeoBundle 'rbtnn/rabbit-ui-collection.vim'
  NeoBundle 'scrooloose/nerdtree'
	
	
filetype plugin indent on     " required!
filetype indent on


" neocompleteの設定
let g:acp_enableAtStartup = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scala' : $HOME . '/.vim/dict/scala.dict',
    \ }
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
endif

" コメントアウト／コメントイン切り替え
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" vim-tags
nnoremap <C-]> g<C-]>

autocmd ColorScheme * highlight Comment ctermfg=247 guifg=#008800
colorscheme molokai
let g:molokai_original=1

" set g:agprg="ag --column"


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

" 文字コードの自動判定
"行頭のスペースの連続をハイライトさせる
"Tab文字も区別されずにハイライトされるので、区別したいときはTab文字の表示を別に
"設定する必要がある。
function! SOLSpaceHilight()
    syntax match SOLSpace "^\s\+" display containedin=ALL
    highlight SOLSpace term=underline ctermbg=LightGray
endf
"全角スペース　をハイライトさせる。
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    " highlight JISX0208Space term=underline ctermbg=LightCyan
    highlight JISX0208Space term=underline ctermbg=7 guifg=7
" 	syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
" 	highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
" 	syntax match InvisibleTab "\t" display containedin=ALL
" 	highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
 endf
"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    " syntax on
         augroup invisible
         autocmd! invisible
         " autocmd BufNew,BufRead * call SOLSpaceHilight()
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

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


set clipboard+=autoselect      " visual selection -> clipboard
set clipboard+=unnamed         " yank -> clipboard

" エンコード
set encoding=utf8
" md as markdown, instead of modula2


" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
 " vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
nnoremap <leader>n :NERDTree<CR>
" デフォルトでツリーを表示させる
 " autocmd VimEnter * execute 'NERDTree'

"コピペで貼り付けたときずれないように
set paste
set cursorline
