set nu
"在底部显示，当前处于命令模式还是插入模式
set showcmd

autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
"突出显示当前行

set t_Co=256
"set cursorline "等同于 set cul


autocmd InsertEnter * se cul    " 用浅色高亮当前行 

"突出显示当前列
"set cursorcolumn "等同于 set cuc

" 光标行高亮
"set cursorcolumn
set cursorline
highlight CursorLine   cterm=NONE ctermbg=255 ctermfg=NONE guibg=NONE guifg=NONE
"highlight CursorLine   cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
"highlight CursorcoLumn cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE


"搜索忽略大小写
set ignorecase

"语法高亮
syntax on
set tabstop=8
set softtabstop=8
set shiftwidth=8
set autoindent

"
"nmap <F2> <esc>:Tlist<cr>
"map <C-n> :NERDTreeToggle<CR> 

"设置ruler会在右下角显示光标所在的行号和列号,不方便查看,改成设置状态栏显示内容
"set ruler
set autoread

"1=启动显示状态行, 2=总是显示状态行.设置总是显示状态行,方便看到当前文件名
set laststatus=2

"设置背景主题 
"color asmanian
"设置字体
set guifont=Courier_New:h10:cANSI
"设置颜色主题,适用于黑色背景.
colorscheme darkburn

"set t_Co=256
"colorscheme default

"=============显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

set autochdir
set tags=tags;
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
map <c-]> g<c-]>

"设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"保存.vimrc文件时自动重启加载，即让此文件立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC



"设置状态行显示的内容. %F: 显示当前文件的完整路径. %r: 如果readonly,会显示[RO]
"%B: 显示光标下字符的编码值,十六进制. %l:光标所在的行号. %v:光标所在的虚拟列号.
"%P: 显示当前内容在整个文件中的百分比. %H和%M是strftime()函数的参数,获取时间.
set statusline=%F%r\---------------------------------\ [HEX=%B][line:%l,%v,%P]\ %{strftime(\"%H:%M\")}

"共享剪贴板  
set clipboard+=unnamed 

"高亮显示所有搜索到的内容.后面用map映射快捷键来方便关闭当前搜索的高亮.
set hlsearch
"hi Search term=standout cterm=bold ctermfg=7 ctermbg=1
hi Search term=reverse ctermbg=4
"光标立刻跳转到搜索到内容
set incsearch

"搜索到最后匹配的位置后,再次搜索不回到第一个匹配处
set nowrapscan

" 默认按下Esc后,需要等待1秒才生效,设置Esc超时时间为100ms,尽快生效
set ttimeout
set ttimeoutlen=100

"让Backspace键可以往前删除字符.
"Debian系统自带的vim版本会加载一个debian.vim文件,默认已经设置这一项,
"可以正常使用Backspace键.如果使用自己编译的vim版本,并自行配置.vimrc文件,
"可能就没有设置这一项,导致Backspace键用不了,或者时灵时不灵.所以主动配置.
"使回格键（backspace）正常处理indent, eol, start等
set backspace=indent,eol,start

"允许backspace和光标键跨越行边界
"set whichwrap+=<,>,h,l


"FIXME 在MS-DOS控制台打开vim时,控制台使用鼠标右键来复制粘贴,设置
"全鼠标模式,鼠标右键被映射为visual mode,不能用来复制粘贴,不方便.
"但是如果不设置鼠标模式,会无法使用鼠标滚轮来滚动界面.经过验证,发现
"可以设成普通模式mouse=n来使用鼠标滚轮,也能使用鼠标右键复制粘贴.
" mouse=c/mouse=i模式都不能用鼠标滚轮. Linux下还是要设成 mouse=a
set mouse=a
"set mouse=n
"set selection=exclusive
"set selectmode=mouse,key

"高亮显示括号匹配
set showmatch
"显示空格和tab键
set list                     " 显示Tab符，使用一高亮竖线代替
set listchars=tab:>-,trail:-
set listchars=tab:\|\,
set lcs=tab:\|\ ,nbsp:%,trail:-  "将tab之后用|显示对齐的竖线



"=============新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 

""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == '.sh' 
        call setline(1,"\#!/bin/bash")

        call append(line("."), "\############################") 
        call append(line(".")+1, "\# File Name: ".expand("%")) 
        call append(line(".")+2, "\# Author: Edwin") 
        call append(line(".")+3, "\# -------------")
        call append(line(".")+4, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+5, "\############################") 
        call append(line(".")+6, "") 
    else
        call setline(1, "/**************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author:Edwin") 
        call append(line(".")+2, "-----------------------------")
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************/") 
        call append(line(".")+5, "")
    endif
endfunction

