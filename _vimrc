
set nocp

"" Platform
function! MySys()
  if has("win32")
    return "windows"
  endif

  if has("unix")
    let s:uname = system("echo -n \"$(uname)\"")
    if !v:shell_error && s:uname == "Darwin"
        return "mac"
    endif
  endif

  return "linux"
endfunction
let g:platform = MySys() 

let g:VIM_GIT_CONF_PATH = get(g:, 'VIM_GIT_CONF_PATH', "NONE")
if g:VIM_GIT_CONF_PATH == "NONE"
  if 'windows' == g:platform
    let $VIM_PLUGIN = $HOME . "/vimfiles"  
  else
    let $VIM_PLUGIN = $HOME . "/.vim"
  endif
else
    let $VIM_PLUGIN = g:VIM_GIT_CONF_PATH . "/vim"
endif

set runtimepath+=$VIMRUNTIME
set runtimepath+=$VIM_PLUGIN
let $MYVIMRC2 = $VIM_PLUGIN . "/vimrc.vim"  

"" install vim plguin Vimballs (.vba)?
"" :e xx_name.vba
"" :!mkdir ~/.vim/bundle/xx_name
"" :UseVimball ~/.vim/bundle/xx_name


""--------------------------------------------
"" pathogen.vim
""-------------------------
"http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
"http://www.vim.org/scripts/script.php?script_id=2332
":helptags

"call pathogen#infect()
"syntax on   " Enable syntax highlighting
"filetype plugin indent on " Enable filetype-specific indenting and plugins

"filetype off                                                                
"call pathogen#infect('~/.vim/bundle')
"call pathogen#helptags()

 call pathogen#runtime_append_all_bundles()
 filetype off
 syntax on
 filetype plugin indent on


""--------------------------------------------



if filereadable($MYVIMRC2)
  source $MYVIMRC2
else
"  echoerr 'the customer vimrc#'. $MYVIMRC2 ' is no exist!, pls refer vimrc_bk.vim'.
endif 


"" In macvim map <apple-shift-arrow> to switch tab
if 'mac' == g:platform && has("gui_running") 
  map <D-S-left> :tabprevious<CR>
  map <D-S-right> :tabnext<CR> 
  map <D-S-[> :tabprevious<CR>
  map <D-S-]> :tabnext<CR>
endif 


set autoread    " 自动载入,用于不同编辑器处理同一文件时
set autowriteall
set t_Co=256

set noswapfile
"set ignorecase
"set smartcase


let g:EasyMotion_leader_key = '<Leader>'


"---------------------------------------------
"" copy and paste setting
"----------------------------------
if 'windows' == g:platform
  "" for windows setting
  "" in windows register '+' is the same with '*' 
  set clipboard+=unnamed  " Yanks go to clipboard instead.
elseif 'mac' == g:platform && $TMUX == ''
  "" for mac setting
  "" in windows register '+' is the same with '*' 
  set clipboard=unnamed  " Yanks go to clipboard instead.
else
  "----------------------------------
  "" for linux setting
  "" vim's system clipboard is register '+'
  "" in linux vim, the register '+' is not '*' 
  
  "" copy to system clipboard
  vmap <c-c> "+y
  "" cut to system clipboard
  vmap <c-x> "+d
  
  "" <SHIFT-Insert> to Paste
  nnoremap <silent> <SID>Paste "=@+.'xy'<cr>gPFx"_2x
  map  <S-Insert>        <SID>Paste
  imap <S-Insert>        x<Esc><SID>Paste"_s
  cmap <S-Insert>        <c-r>+
  vmap <S-Insert>        "-cx<Esc><SID>Paste"_x
  imap <c-v>        x<Esc><SID>Paste"_s
  "---------------------------------------------
endif


let mapleader = "," 
"let maplocalleader = ","

set wildmenu         "enable ctrl-n and ctrl-p to scroll thru matches


"" make Y consistent with C and D
nnoremap Y y$


"" 使得 Vim 在执行自动命令时回显之
"" set verbose=9



"" 设置语言和编码
augroup utf8
  autocmd!
  autocmd BufNewFile,BufNew,BufCreate,BufAdd * call SetUtf8WhenNew() 
augroup END

function! SetUtf8WhenNew() 
  set modifiable
  if &modifiable
    set nobomb                              "BOM(字节顺序标记)
    set fileformat=unix                     "设置缓冲区换行符格式  
    set fileformats=unix,dos,mac            "设置换行符格式   
    set encoding=utf-8
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
    set termencoding=utf8
  endif
endfunction

set langmenu=en

call SetUtf8WhenNew() 
set showcmd
set ambiwidth=double  "防止特殊符号如五角星无法正常显示


if has('eval')
  let g:load_doxygen_syntax=1
  let g:is_posix=1
  let g:c_gnu=1
  let g:netrw_special_syntax=1
  let g:netrw_liststyle=3
  let g:netrw_browse_split=4

  " Required to see the current function name in the status bar.
  let Tlist_Process_File_Always = 1

  " Configure HTML output with :TOhtml
  " let html_number_lines=1
  let html_use_css=1
  let html_use_xhtml=1
  let html_dynamic_folds = 1
  let html_number_lines = 0
endif



" This mapping allows to stay in visual mode when indenting with < and >
vnoremap > >gv
vnoremap < <gv




if has("gui_running")
  if 'windows' == g:platform
    "" In Windows platform
    "" 解决consle输出乱码
    language messages zh_CN.utf-8
    set helplang=cn

    "" Vim 在启动时最大化窗口(windows 有效)
    autocmd GUIEnter * simalt ~x
  else
    "" In linux platform

  endif

  set guioptions-=m " 完全隐藏菜单
  set guioptions-=T " 完全隐藏工具栏
  set guioptions-=r
  set guioptions-=R
  set guioptions-=L
  set guioptions-=l

  "" 解决菜单乱码
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim  

  "" 在GVim中绑定到切换菜单和工具栏
  map <silent> <c-F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
  \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
  \endif<cr>



  "colorscheme vibrantink
  "colorscheme ir_black
  "colorscheme blackboard

  if 'windows' == g:platform
    "" In GUI Windows platform
    
    colorscheme molokai
    let g:molokai_original = 0
  else
    "" In GUI linux/mac platform
   colorscheme blackboard 
  endif 

else  
  ""in command line 

  "colorscheme candy
  colorscheme blackboard
  "colors pyte 

endif


"---------------------------------------------
"" http://kien.github.com/ctrlp.vim/
"----------------------------------
set runtimepath^=~/.vim/bundle/ctrlp
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
nmap <silent> <Leader>t :CtrlP<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip  " MacOSX/Linux

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.class$\|\.o$\|\~$\|\.DS_Store',
  \ 'link': 'some_bad_symbolic_links',
  \ }


let g:ctrlp_extensions = [
   \ 'ctrlp-filetpe',
   \ ]
let g:ctrlp_follow_symlinks = 1


"---------------------------------------------
"see https://github.com/airblade/vim-rooter

" Rooter patterns for identifying root path
let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']

" Change root directory on buffer enter
augroup Rooter
    autocmd!
    autocmd BufEnter * :Rooter"
augroup END


"---------------------------------------------
"" font setting
"----------------------------------
if 'windows' == g:platform
  "set guifont=ProggyCleanCP:h12:cANSI
  "set guifont=ProggyCleanTT:h12:cDEFAULT
  set guifont=MONACO:h15
  "set guifont=Fixedsys:h11
  "set guifont=Consolas:h11:cDEFAULT
elseif 'mac' == g:platform
  "set guifont=ProggyCleanCP:h12:cANSI
  "set guifont=ProggyCleanTT:h12:cDEFAULT
  set guifont=MONACO:h15
  "set guifont=Fixedsys:h11
  "set guifont=Consolas:h11:cDEFAULT
else 
  ""linux
  "set guifont=Consolas\ 11
endif

"---------------------------------------------




"" 搜索高亮
map <silent> <F3> :call SetHlsearch()<cr>
set hlsearch
let s:hlsearch=1
function! SetHlsearch()
  if s:hlsearch==0
    let s:hlsearch=1
    set hlsearch
  elseif s:hlsearch==1
    let s:hlsearch=0
    set nohlsearch
  endif
endfunction




"" Backups & Files
let $vim_backupdir = $HOME . "/vim_backup"
let $vim_tmpdir = $HOME . "/vim_tmp"
if !isdirectory($vim_tmpdir)
  silent! call mkdir($vim_tmpdir, 'p')
endif
set directory=$vim_tmpdir      " Directory to place swap files in
if !isdirectory($vim_backupdir)
  silent! call mkdir($vim_backupdir, 'p')
endif
set backup                     " Enable creation of backup file.
set backupdir=$vim_backupdir   " Where to put backup files



set nocompatible                 " We're running Vim, not Vi!
set guitablabel=%M%t

"" folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png,*~    "stuff to ignore when tab completing

"" vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"" 高亮当前行
"set cursorline

set cf          " Enable error files & error jumping.

set autowrite   " Writes on make/shell commands
set ruler       " Ruler on
set number      " Line numbers on
set nowrap      " Line wrapping off



"" By default Vim will only wait 1 (1000 milliseconds) 
"" second for each keystroke in a mapping.

"" timeout in milliseconds
"set timeoutlen=2000  
"" timeout for key codes in milliseconds
"set ttimeoutlen=100  
"set notimeout

set tw=78 fo+=Mm 

"" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent



"---------------------------------------------------------------------
"" MRU.vim Setting
"----------------------------------------- 

augroup MRU
  autocmd!
  nmap <silent> mm <esc>:MRU<cr>
  let MRU_Max_Entries = 60
  let MRU_Exclude_Files = '.*\.pdf$\|.*\.zip$\|.*\.rar$\|.*\.7z$\|.*\.class$\|.*\.wiki$'
  let MRU_Exclude_Files .= '\|.*BExec_output.*\|.*NERD_tree_.*\|.*__MRU_Files__.*'
  let MRU_Exclude_Files .= '\|.*favex/favlist\|.*\.fugitiveblame'
  
  
  let MRU_Add_Menu = 0 
  
  
  " Autocommands to detect the most recently used files
  autocmd BufRead * call g:MRU_AddFile(expand('<abuf>'))
  autocmd BufNewFile * call g:MRU_AddFile(expand('<abuf>'))
  autocmd BufWritePost * call g:MRU_AddFile(expand('<abuf>'))
  autocmd BufWritePre,FileWritePre,BufWriteCmd   *NERD_tree_* call CancelSave()
  fun! CancelSave()
    echomsg "![E+] Can not save \""expand("%:p")."\""
    return 0
  endfun          
  
  
  " The ':vimgrep' command adds all the files searched to the buffer list.
  " This also modifies the MRU list, even though the user didn't edit the
  " files. Use the following autocmds to prevent this.
  autocmd QuickFixCmdPre *vimgrep* let g:mru_list_locked = 1
  autocmd QuickFixCmdPost *vimgrep* let g:mru_list_locked = 0
  
  autocmd BufRead,BufNewFile *__MRU_Files__*  setlocal  cursorline
  
  " Command to open the MRU window
  command! -nargs=? -complete=customlist,g:MRU_Complete MRU
              \ call g:MRU_Cmd(<q-args>)    

augroup END
"---------------------------------------------------------------------




"------------------------------------------------ 
"" ruby unit test
"---------------------------- 
let test#ruby#runner = 'm'
let g:test#runner_commands = ['M']
let test#ruby#bundle_exec = 0
let g:test#ruby#minitest#executable = 'm'

"https://github.com/janko-m/vim-test/blob/master/autoload/test/ruby/m.vim

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
"nmap <silent> t<C-n> :TestNearest<CR>
"nmap <silent> t<C-f> :TestFile<CR>
"nmap <silent> t<C-l> :TestLast<CR>
"nmap <silent> t<C-g> :TestVisit<CR>
"nmap <silent> t<C-s> :TestSuite<CR>

augroup rubyunittest
  autocmd!
  "autocmd BufRead,BufNewFile *_test.rb       nmap <buffer> tt :lcd %:p:h <bar> TestNearest<CR>
  "autocmd BufRead,BufNewFile *_test.rb       nmap <buffer> tf :lcd %:p:h <bar> TestFile<CR>
  "autocmd BufRead,BufNewFile *.rb       nmap <buffer> tl :TestLast<cr>

  autocmd BufRead,BufNewFile *.rb  nmap <buffer> tf :call g:RubyUnitTestFile()<cr>
  autocmd BufRead,BufNewFile *.rb  nmap <buffer> tt :call g:RubyUnitTestCase()<cr>
  autocmd BufRead,BufNewFile *.rb  nmap <buffer> gt :call g:RubySwitchTest()<cr>

  function! g:RubySwitchTest()
    :lcd %:p:h
    let file_relative_name = expand("%")
    let file_relative_name_no_ext  = expand("%:r")

    let index_start = match(file_relative_name, "_test.rb$")
    if -1 != index_start
        "end with _test.rb, ie. current in _test.rb
        let target_file = file_relative_name[0:index_start-1] . ".rb"
        "echo "file_relative_name:". file_relative_name
        "echo "index_start:".index_start 
        "echo "target_file:".target_file
    else
        let target_file = file_relative_name_no_ext . "_test.rb"
    endif 

    let cmd = "e " . target_file
    "echo cmd
    :execute cmd
  endfunction


  function! g:RubyUnitTestFile()
    :lcd %:p:h
    let file_relative_name = expand("%")
    let file_relative_name_no_ext  = expand("%:r")

    if -1 != match(file_relative_name, "_test.rb$")
        "end with _test.rb, ie. current in _test.rb
        let test_file = file_relative_name
        let cmd = "!clear && m " . test_file
        :execute cmd
    else
        let test_file = file_relative_name_no_ext . "_test.rb"
        let cmd = "!clear && m " . test_file
        :execute cmd 
    endif 
  endfunction
  
  function! g:RubyUnitTestCase()
    :lcd %:p:h
    let file_relative_name = expand("%")
    let file_relative_name_no_ext  = expand("%:r")

    if -1 != match(file_relative_name, "_test.rb$")
        "end with _test.rb, ie. current in _test.rb
        let test_file = file_relative_name
        let cmd = "!clear && m " . test_file . ":". line(".")
        :execute cmd
    else
        let test_file = file_relative_name_no_ext . "_test.rb"
        let cmd = "!clear && m " . test_file
        :execute cmd 
    endif 
  endfunction

augroup END




"------------------------------------------------ 
"" rails.vim
"---------------------------- 
"How to create project based rvmrc:
" cd myproject
" rvm --rvmrc --create 1.8.7@myproject

function! Set_rails_project_root()
  let g:project_root = CurDir() 
endfunction

"autocmd! BufRead,BufNewFile *_spec.rb       nmap  tt :call g:TRailsTest()<cr>
"autocmd! BufRead,BufNewFile *_spec.rb       nmap  tt :call g:TRailsTest()<cr>


function! g:TRailsTest()
  let file_path_name = expand("%:p")
  let line_num = line('.') 

  let cmd_name = "bundle exec spec"
  if -1 != match(file_path_name, "_spec.rb$")
      let cmd_name = "bundle exec rspec"
  endif 
  if -1 != match(file_path_name, "feature$")
      let cmd_name = "bundle exec cucumber"
  endif
  
  let line_str = ":" . line_num
  if line_num < 3
     let line_str = ""
  endif

  let command = cmd_name . " ". file_path_name . line_str
  call g:AsynCommand(command)
endfunction 
                                                                


"" Switch to current dir
"" and NERDTree init and render a new tree


function! Map_cd()
  if exists("b:rails_root") 
    let g:project_root=b:rails_root
    let current_cwd = getcwd()
    if current_cwd ==? g:project_root
      NERDTreeFind
      execute 'cd ' . b:rails_root
    else
      execute 'cd ' . b:rails_root
      Rtree
    endif
  else
    let g:project_root=expand("%:p:h")
    cd %:p:h
    NERDTreeFind
  end
endfunction


"" Switch to current dir
"" and NERDTree init and render a new tree
map <silent> cd  <esc>:call Map_cd()<cr>


let NERDTreeDirArrows=0


augroup Rails
  autocmd!
  autocmd User Rails		silent! Rlcd
  autocmd User Rails		call Set_rails_project_root()
augroup END
"------------------------------------------------ 




"------------------------------------------------ 
"" tab setting
"---------------------------- 
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']


function! g:SetTab(expandEnable, spaceNum) 
  let spaceNum = a:spaceNum
  let expandEnable = a:expandEnable

  ""当 'smarttab' 选项打开时，<Tab> 在行首插入 'shiftwidth' 个位置，而在其它地方插
  ""入 'tabstop' 个。这意味着经常会插入空格而不是 <Tab> 字符。当 'smarttab' 关闭
  ""时，<Tab> 总是插入 'tabstop' 个位置，而 'shiftwidth' 只有在 ">>" 和类似的命令
  ""中才会用到 
  set smarttab

  "" 输入tab时自动将其转化为空格 
  "" 如果此时需要输入真正的tab，则输入Ctrl+V, tab，在windows下是Ctrl+Q, tab 
  "" 将已存在的tab都转化为空格命令 :retab
  if expandEnable
    set expandtab
  else
    set noexpandtab 
  endif

  ""一个tab字符的长度
  execute ':set tabstop='.spaceNum  
  
  ""vim中自动缩进，或者'<','>',ctrl+T,ctrl+D命令产生的空格数
  execute ':set shiftwidth='.spaceNum  

  ""当按下tab键时，产生的空格数。当产生的softtab可以转换成一个tab字符时，vim自动将空格转换成tab字符 
  ""如tabstop=8, softtabstop=4, 按一下tab产生4个空格，再按一下tab会把两次产生的8个空格转换成一个tab字符
  execute ':set softtabstop='.spaceNum  
endfunction

call g:SetTab(1, 4)




"" 开关:是否显示Tab等不可见字符
"set list
set nolist

"" 定义显示<TAB>的方式:高亮<tab>
set listchars=tab:\ \ ,extends:>,precedes:<

"------------------------------------------------ 



"" Visual
set showmatch     " Show matching brackets.
set mat=5         " Bracket blinking.


"" gvim specific
set mousehide     " Hide mouse after chars typed
"set mouse=a      " Use mouse everywhere 
source $VIM_PLUGIN/filetype.vim


"" 保存全局变量
set viminfo+=!


" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

"" 总是显示状态行:2
set laststatus=2

" 命令行（在状态行下）的高度，默认为1
set cmdheight=1

" 高亮字符，让其不受100列限制
highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
match OverLength '\%101v.*'



"" 允许backspace和光标键跨越行边界
"set whichwrap+=<,>,h,l


" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atIT


"" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\


function! CurDir()
 let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
 return curdir
endfunction


source $VIM_PLUGIN/bundle/LargeFile/plugin/LargeFile.vim
source $VIM_PLUGIN/bundle/mygit/plugin/mygit.vim 
source $VIM_PLUGIN/bundle/fugitive/plugin/fugitive.vim 

function! GetCurrPasteMode()
 return g:CurrPasteMode
endfunction

"" Format the statusline
"set statusline=\ %f%m%r%h\ \ %=[%{GitBranch()}]\ %w\ \ CWD:\ %{CurDir()}%h\ \ %=%-40(line=%l,col=%c%V,totlin=%L%)\%P
"set statusline=\ %f%m%r%h\ \ %=[%{GitBranch()}]\ %w\ \ CWD:\ %{CurDir()}%h
set statusline=\ %f%m%r%h\ \ %=[%{GitBranch()}]\ %w\ %{GetCurrPasteMode()}%h\ CWD:\ %{CurDir()}%h
"set statusline=\ %f%m%r%h\ \ %=[%{GitBranch()}]\ %w\ %{()} \ CWD:\ %{CurDir()}%h\ %{GetCurrPasteMode()}%h



set bsdir=buffer

"" aotu change the :pwd to the current dir
"set autochdir 


set history=512   "" Number of things to remember in history.


map s <Nop>


"" Fast reloading of the .vimrc
map <silent> <leader>ss :source $MYVIMRC<cr>

"" Fast editing of .vimrc
map <silent> <leader>ee :e $MYVIMRC<cr>

map <silent> <leader>eb :e $HOME/.NERDTreeBookmarks<cr>
""map <silent> <leader>ed :e $VIM_PLUGIN/vimrc.vim<cr>


augroup VIMRC
  autocmd!
  "" autoload _vimrc if you edit _vimrc in vim
  "autocmd! bufwritepost *vimrc,*.vim source %
  autocmd! bufwritepost $MYVIMRC source %
  autocmd! bufwritepost *.vim ReloadScript % 
augroup END





function! Dos2Unix()
  set fileformat=unix 
  write
endfunction


function! Unix2Dos()
  set fileformat=dos
  write
endfunction


" 以下符号是单词的一部分,不要对他们换行分割(在自动补齐和单词搜索如<S-8>时很有用) 
" @ -> 所有字母, 48-57 -> 数字0-9
autocmd BufRead,BufNewFile *.tcl,*.test  setlocal  iskeyword=@,48-57,_
autocmd BufRead,BufNewFile *.php         setlocal  iskeyword=@,48-57,_
autocmd BufRead,BufNewFile *.mkd         setlocal spell

autocmd! BufRead,BufNewFile *.scala       nmap  tt :call g:RunScala()<cr>

function! g:RunScala()
  let command = "scala ". expand("%:p")
  call g:AsynCommand(command)
endfunction 



"------------------------------------------------------
"" Open Tlist with <mt>
"-------------------------- 
"source $VIM_PLUGIN/plugin/taglist.vim 

function! s:GetVisualSelection()
  let save_a = @a
  silent normal! gv"ay
  let res = @a
  let @a = save_a
  return res
endfunction

function! TagVisual()
  let content = s:GetVisualSelection()
  if "" == content
    return
  endif

  exec "Mark " . content
  
  "" sp or vsp ?
  exec "silent!sp"
  exec "wincmd p"
  exec "tag " . content 
endfunction

""taglist窗口是最后一个窗口时退出VIM，设置 1
let Tlist_Exit_OnlyWindow = 0 
""使taglist以tag名字进行排序
let Tlist_Sort_Type = "name" 
""不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File = 1 
""打开taglist窗口时，输入焦点在taglist窗口中
let Tlist_GainFocus_On_ToggleOpen = 1 
""选择了tag后自动关闭taglist窗口
let Tlist_Close_On_Select = 0 
"" Close Tlist with resize
let Tlist_Inc_Winwidth=0
"" 不要显示折叠树
let Tlist_Enable_Fold_Column = 0

""新开一个window打开visual模式下的tag
vmap <silent> <c-w>]   :call TagVisual()<cr>

"map <silent> mt <esc>:Tlist<cr>
nmap <silent> mt <esc>:call TaglistKeyMap()<cr> 
function! TaglistKeyMap() 
  if &filetype != 'java'
    ""not java use Tlist
    exec "Tlist"
  else
    "" java, use JavaBrowser
    exec "JavaBrowser"
  endif
endfunction



"------------------------------------------------------




"------------------------------------------------------
"" Open quickfix window
"--------------------------
map  <silent> <F7> :call QuickFixWin()<cr>

"" QuickFix 高亮当前行
autocmd BufReadPost quickfix  setlocal cursorline
      \ | silent exec "nnoremap <silent> <buffer> q :cclose<cr>"

let s:bQuick=0
function! QuickFixWin()
  if s:bQuick==0
    let s:bQuick=1
    copen
  elseif s:bQuick==1
    let s:bQuick=0
    cclose
  endif
endfunction



autocmd CmdwinEnter * setlocal cursorline
      \ | silent exec "nnoremap <silent> <buffer> q :q<cr>"



"" use Ctrl+x+[l|n|p|cc] to list|next|previous|jump to count the result
map <c-x>l <esc>:cl<cr>
map <c-x>n <esc>:cn<cr>
map <c-x>p <esc>:cp<cr>
map <c-x>c <esc>:cc 

"" to navigate between entries in QuickFix
map <silent> gp :cp <cr>
map <silent> gn :cn <cr>

"------------------------------------------------------




"" Alt+j break the current line
nmap <a-j> i<cr><Esc>k$

map! <c-l> <DEL>


"map <Space> <c-F>
"map <S-Space> <c-B>

"" In insert and cmd modems to hjkl
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

"noremap <C-w> <esc><c-w>-
"noremap <C-w> <esc><c-w>+


"" just works in gui :)
map <c-h> <esc><c-w>h
map <c-j> <esc><c-w>j
map <c-k> <esc><c-w>k
map <c-l> <esc><c-w>l




func! Grep_Quickfix(str) 
  let content = a:str
  if "" == content
    return
  endif

  "" first, to clear all the marks.
  exec "Mark"
  "" then call mark.vim to mark it.
  exec "Mark " . content 

  cd %:p:h

  let cur_file = expand("%")
  let cmd = "vimgrep /\\V".content."/ ". cur_file
"  echoerr "#".cmd."#"
  exe cmd
  exe 'copen' 
endfun

"" vimgrep current word in current file
"" and show result in quickfix window
func! Grep_Word_Quickfix() 
  let content = "\\<".expand("<cword>")."\\>"
  call Grep_Quickfix(content)
endfun


"" vimgrep selected(visual) in current file
"" and show result in quickfix window
func! Grep_Visual_Quickfix() 
  let content = s:GetVisualSelection()
  call Grep_Quickfix(content)
endfun
nmap <silent> <F4> :call Grep_Word_Quickfix()<cr>
vmap <silent> <F4> :call Grep_Visual_Quickfix()<cr>


"" visual search mappings
"" to search the selected word
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<c-u>call <SID>VSetSearch()<cr>//<cr>
vnoremap # :<c-u>call <SID>VSetSearch()<cr>??<cr> 

"" In visual modem, put / to search the selected word
vmap / y/<c-r>"<cr>



""  EasyGrep setting
let g:EasyGrepCommand = 1
"let g:EasyGrepFileAssociations = "C:\\Program Files\\Vim\\vim72\\plugin\\EasyGrepFileAssociations"
let g:EasyGrepRecursive = 1
let g:EasyGrepHidden = 0
let g:EasyGrepExtraWarnings=0
let g:EasyGrepIgnoreCase= 1




"-------------------------------------------------------------------
""  NERDtree setting
"---------------------------------------------
""  ref: $HOME/.NERDTreeBookmarks

let g:NERDTreeWinPos="right"
let g:NERDTreeMapMenu="M"

""  NERDTree ignore ['expression-a', 'expression-b']
let NERDTreeIgnore=['^CVS$', 'phpMyAdmin', 'svn$', '\.git$', '^Thumbs.db$', '.class$']
""  NERDTree render the exist tree
map <silent> mv :NERDTreeToggle<cr>


"-------------------------------------------------------------------



"-------------------------------------------------------------------
"" Ack Plugin
""
"" Description:
""  This plugin allows vim to use the faster and easier ack-grep tool for
""  searching inside files.
""
"" Prerequisites:
""  - Make sure you have the base system packages installed including git-core.
""  - Make sure you have the pathogen.vim plugin installed correctly.
""
"" Installation:
""  $ sudo aptitude install ack-grep
""  $ mkdir -p $HOME/.vim/bundle
""  $ git submodule add https://github.com/mileszs/ack.vim $HOME/.vim/bundle/ack

""
"" Usage:
""  - :Ack [options] {pattern} [{directory}]
""
"" Resources:
""   http://betterthangrep.com/
""   http://amaslov.wordpress.com/2009/04/23/vim-ack-instead-of-grep/ 
"let g:ackprg="ack -H --nocolor --nogroup --column"
let g:ackhighlight=1

"https://github.com/ggreer/the_silver_searcher
"The Silver Searcher based on ack but 3x faster than ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"-------------------------------------------------------------------



" Open bufexplorer with <F9>
"map <silent> <F9> :BufExplorer<cr>


"" Close Tlist with resize
let Tlist_Inc_Winwidth=0



"" 取消光标闪烁
set guicursor=a:block-blinkon0,i-ci:ver25-Cursor/lCursor,v-ve:ver25-Cursor/lCursor


"set novisualbell  " No blinking .
"set noerrorbells  " No noise.
""  使用visualbeep（闪屏）取代 bell发声
"set visualbell t_vb=   

""  同时删除bell发声和闪屏
""  Note: When the GUI starts, 't_vb' is reset to its default value.  You
""  might want to set it again in your |gvimrc|, or in the end of your $VIMRUNTIME/menu.vim.
""  see :help gvimrc for more detail
set vb t_vb=





"" js语法高亮脚本的设置 
let javascript_enable_domhtmlcss=1


"" 匹配括号的规则，增加针对html的<> 
set matchpairs=(:),{:},[:],<:> 



""Ctrl-x Ctrl-n word自动完成
""Ctrl-x Ctrl-l 行自动完成
""Ctrl-x Ctrl-f 文件名自动完成
""Ctrl-x Ctrl-k 自动完成字典

"---------------------------------------------------------------------
"" 设置自动完成字典   <c-x><c-k>
"---------------------------------
"autocmd FileType php    set dictionary=$VIM_PLUGIN/dict/php.dict   
"autocmd FileType python set dictionary=$VIM_PLUGIN/ftplugin/pydiction/complete-dict
"autocmd FileType php set dictionary+=$VIM_PLUGIN/dict/sql.dict   
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""   


"autocmd FileType c      source $VIM_PLUGIN/ftplugin/c/hints_man3.vim
"      \ | set ch=2


map <silent> <leader>ss :source $MYVIMRC<cr>



" ------------------------------------------------
"" 自动补全括号
" -------------------------------------
function! g:SwitchMapComplete(CurMapComplete)
  if a:CurMapComplete == 1
    inoremap " ""<esc>i
    inoremap ' ''<esc>i
    inoremap ( ()<esc>i
    inoremap [ []<esc>i
    inoremap { {}<esc>i
    set nopaste
  else
    inoremap " "
    inoremap ' '
    inoremap ( (
    inoremap [ [
    inoremap { {
    set paste
  endif
endfunction 
command! -nargs=0  SwitchPasteOn  :call g:SwitchMapComplete(0)
command! -nargs=0  SwitchPasteOff :call g:SwitchMapComplete(1)
"call g:SwitchMapComplete(1)
" ------------------------------------------------


" ------------------------------------------------
let g:PasteMode='[PasteMode]'
let g:CurrPasteMode=""
set nopaste
function! g:SwitchPaste()
  if g:CurrPasteMode== g:PasteMode
    set nopaste
    let g:CurrPasteMode=""
    echomsg "No Paste Mode"
  else
    let g:CurrPasteMode=g:PasteMode
    echomsg "Paste Mode"
    set paste
  endif
endfunction 

nmap <silent> <F2> :call g:SwitchPaste()<cr>
vmap <silent> <F2> :call g:SwitchPaste()<cr>
" ------------------------------------------------

"" for LargeFile.vim, Mbytes
let g:LargeFile = 2


"" in insert mode to auto scroll
let g:IAutoScrollMode="on" 

augroup autoscroll
  autocmd!
  autocmd! CursorMovedI * silent call ICheck_Scroll() 
augroup END

function! ICheck_Scroll()
    " we only check scroll when enabled:)
    if g:IAutoScrollMode == "on"
        " first, get the line number in window
        let cursor_line_no = winline()
        " second, get the window height
        let winht = winheight(winnr())
        " if we hit the bottom, just move to center or top
        if cursor_line_no == winht || cursor_line_no == 1
            " now store get the current line and column
            let cur_line = line('.')
            let cur_col = col('.')
            " OK, we are ready to move :)
            exec "normal zz"
            " we need move cursor back to the original place,
            " otherwise insert mode in new line
            " would put cursor one space ahead. 
            exec "call cursor(cur_line,cur_col)"
        endif
    endif
endfunction

imap <c-f>      <Right>
imap <c-b>      <Left>
imap <c-p>      <Up>
imap <c-n>      <Down>
imap <c-a>      <Home>
imap <c-e>      <End>


""--------------------------------------------
" Window resizing mappings 
""-------------------------

if bufwinnr(1)
  map + 8<C-W>+
  map = 8<C-W>+
  map - 8<C-W>-
  map _ 8<C-W>-
  map < 8<C-W><
  map > 8<C-W>>
endif





