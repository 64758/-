" ==判断操作系统==
if(has("win64") || has("win32"))
	let g:isWin = 1
	let g:isUnix = 0
else
	let g:isWin = 0
	let g:isUnix = 1
endif

" ==功能配置项==

" 不与 Vi 模式兼容
set nocompatible
" 显示行号
set nu
" 显示标尺
set ruler
" 设置 quickfix 在新标签中打开文件
set switchbuf=useopen,usetab,newtab
" 安装的 Vundle 插件要求此项为 off
filetype off
" 安装的 nerdcommenter 插件建议此项为 on
filetype plugin on
filetype indent on
" 开启语法高亮
syntax on
" 开启自动缩进，缩进宽度为 4 个空格
set autoindent shiftwidth=4
" 开启 C 语言风格的自动缩进，缩进宽度为 4 个空格
set cindent shiftwidth=4
" 设置 tab 键缩进宽度为4个空格
set tabstop=4
" 设置高亮显示匹配的括号
set showmatch
" 设置输入 / 搜索时，实时高亮显示查找结果
set incsearch
" do not hightlight all matches when seaching
set nohlsearch
" 搜素时忽略大小写 
set ignorecase
" 设置字符终端中允许接收鼠标控制
set mouse=a
" windows 下 gvim 编辑模式退格键不响应的问题
set backspace=indent,eol,start
" 和系统共享剪贴板
set clipboard+=unnamed
" 设置 tab 为 space
"set expandtab

" 界面显示
if has('gui_running')
	" 隐藏 gvim 的工具栏
	set guioptions-=T
	" 隐藏 gvim 右侧滚动条 
	"set guioptions-=r
	" 隐藏 gvim 左侧滚动条 
	set guioptions-=L
	" 隐藏 gvim 菜单栏 
	set guioptions-=m
	" 使用内置 tab 样式而不是 gui
	set guioptions-=e

	" 配色方案
	" { solarized
	"set background=dark
	colorscheme solarized
	" }
	"colorscheme base16-default-dark

	" 设置 gvim 的字体
	if(g:isUnix)
		set guifont=Monospace\ 12
	else " windows
		set guifont=YaHei_Consolas_Hybrid:h13:cGB2312
	endif
else 
	" 配色方案
	" { solarized
	"set background=dark
	"colorscheme solarized
	" }
endif

" 文件编码问题
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if(g:isWin)
	set fileencoding=chinese
	" gvim 菜单及右键菜单乱码
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim

	" 处理 console 输出乱码
	language messages zh_CN.utf-8
else
	set fileencoding=utf-8
endif

" ==按键映射==

let mapleader = ";"

" 插入时间的快捷键
iab idt <c-r>=strftime("%Y_%m_%d %H:%M:%S")<CR>
iab idd <c-r>=strftime("%Y_%m_%d")<CR>

" 复制行内文字（不含开头的tab等空白字符）
nnoremap yl ^y$
" 范围内替换
nnoremap <leader>r[ di[<left>"0p
nnoremap <leader>r( di(<left>"0p
nnoremap <leader>r{ di{<left>"0p
nnoremap <leader>r" di"<left>"0p
nnoremap <leader>r< di<<left>"0p
nnoremap <leader>rw viw"0p
nnoremap <leader>"( di(i""<left><ESC>p
" 给行末加上分号
nnoremap ;; $i<right>;<esc>
" 关闭文件
nnoremap <F12> <ESC>:q<CR>

" 插件 AsyncRun
" 打开或关闭 asyncrun quickfix 窗口
noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>
noremap <F5> :wa<cr>:Make<cr>
" 标签页切换快捷键
nnoremap <C-Left> <ESC>:tabprevious<CR>
nnoremap <C-Right> <ESC>:tabnext<CR>
" 全局搜索快捷键
nnoremap <C-f> <ESC>viwy<CR>:cd %:h<CR>:Ack! <C-r>"
" 全局替换快捷键
nnoremap <C-h> <ESC>viwy:%s/<C-r>"//g<left><left>
nnoremap <leader><C-h> <ESC>viwy:s/<C-r>"//g<left><left>

" 插件：The-NERD-Tree
nnoremap <F3> <ESC>:NERDTreeToggle %<CR>
nnoremap <leader><F3> <ESC>:NERDTree %<CR>
" 插件：Tagbar
autocmd FileType markdown nnoremap <F4> <ESC>:Toc<CR>
autocmd FileType cpp,c nnoremap <F4> <ESC>:TagbarToggle<CR>
" 插件：a.vim 
" 在同一窗口切换对应的 .c 和 .h 文件
nnoremap <leader>a <ESC>:A<CR>

" ==插件配置项==
" Vundle settings {
if (g:isWin)
	set rtp+=$VIM/vimfiles/bundle/Vundle.vim
	call vundle#begin('$VIM/vimfiles/bundle')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

" 方便管理插件
Plugin 'VundleVim/Vundle.vim'
" 替代taglist
Plugin 'majutsushi/tagbar'
" 快速搜索打开文件
Plugin 'ctrlpvim/ctrlp.vim'
" 文件夹浏览器
Plugin 'scrooloose/nerdtree'
" 代码搜索工具，需要安装ag，配置见下文
Plugin 'mileszs/ack.vim'
" 优化终端下标签页显示
Plugin 'caipre/tabline.vim'
" 括号补全
Plugin 'Raimondi/delimitMate'
" 执行 cmake，它会递归地找到当前目录往上最近的 build，进入并 cmake ..
Plugin 'vhdirk/vim-cmake'
" 快速添加注释 
Plugin 'scrooloose/nerdcommenter'
" 在对应的 .h 和 .c 文件之间跳转 
Plugin 'vim-scripts/a.vim'
" markdown 相关插件
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" 配色方案 
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
" 异步执行
Plugin 'skywind3000/asyncrun.vim'
" 画图
Plugin 'vim-scripts/DrawIt'
Plugin 'aserebryakov/vim-todo-lists'
call vundle#end()
filetype plugin indent on
" }

" NERDtree {
let NERDTreeQuitOnOpen=1
" }

" ack.vim {
"if executable('ag')
if(g:isWin)
    let g:ackprg = "C:/cygwin64/bin/ag.exe --vimgrep"
endif
"endif
" }

" vim-markdown {
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1
" }

" AsyncRun {
" AsyncRun 启动的时候自动打开 quickfix 窗口
augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
" 将 Make 命令映射成异步执行的 make 命令
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
" }
