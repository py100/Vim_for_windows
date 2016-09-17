"取消错误提示音
set vb t_vb=
au GuiEnter * set t_vb=
set lbr
set mousemodel=popup

au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict

"syntastic相关
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示中文帮助
set helplang=cn
set encoding=utf-8
set termencoding=utf-8
syntax on
set cul "高亮光标所在行
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
set go=             " 不要图形按钮  
"color monokai_modify     " 设置背景主题  
color desert
set guifont=Consolas:h12:cANSI   " 设置字体  
set guifontwide=YouYuan:h12:b:cGB2312 "中文字体

autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  

" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=2
" 统一缩进为2
set softtabstop=2
set shiftwidth=2
" 使用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab
set smartindent
" 显示行号
set number
" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch
"语言设置
set langmenu=zh_CN.UTF-8

"总是显示状态行
set cmdheight=3
" 侦测文件类型
filetype on
"载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-,.
" 字符间插入的像素行数目


"================================"
"           键盘命令             "
"================================"
nmap ; :
:nmap <silent> <F9> <ESC>:Tlist<RETURN>
" shift tab pages

"map! <C-O> <C-Y>,
map <C-c> ggVG$"+y
map <C-w> <C-w>w
map // I//<ESC>


set mouse=v
 
"比较文件  
nnoremap <C-F2> :vert diffsplit 


"列出当前目录文件
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录  
map <C-F3> \be  
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"


"=================================="
"      C，C++ 按F5编译运行         "
"=================================="
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ -std=c++11 % -o %<"
		exec "! %<.exe"
	elseif &filetype == 'cpp'
		exec "!g++ -std=c++11 % -o %<"
		exec "! %<.exe"
	elseif &filetype == 'python'
		exec "!python2.7 %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 设置当文件被改动时自动载入
set autoread

"代码补全 
"set completeopt=preview,menu
"共享剪贴板  
set clipboard+=unnamed 

" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile

set linespace=0
" 增强模式中的命令行自动完成操作

set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
" set mouse=a
set selection=inclusive
set selectmode=mouse,key

" 高亮显示匹配的括号
"set showmatch

"为C程序提供自动缩进
"自动补全


filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
set autochdir 

set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

autocmd FileType python set omnifunc=pythoncomplete#Complete

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'CaptureClipboard'
Bundle 'Vim-Script-Updater'
Bundle 'ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'The-NERD-Commenter'

"required!
filetype plugin indent on

"ctrlp设置
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']
let NERDTreeIgnore=['\.pyc']

"解决菜单乱码
language messages zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

inoremap {} {}
inoremap { {<CR>}<ESC>O
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap () ()<ESC>i
"inoremap ) <c-r>=ClosePair(')')<CR>
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction

autocmd BufNewFile  *.cpp	0r ~/.vim/head.cpp
":autocmd BufNewFile  *.h	0r ~/vim/skeleton.h
":autocmd BufNewFile  *.java	0r ~/vim/skeleton.java