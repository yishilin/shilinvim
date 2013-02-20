"
"（取自帮助文件中，:help new-filetype即可查到）
"   *new-filetype*
" 如果你想使用的文件没检测到文件类型，有四种方法。不管如何，最好不要修改
" $VIMRUNTIME/filetype.vim 文件。再安装新的 Vim 版本的时候它会被覆盖。
"
" 如果你的文件类型可以通过文件名检测。
"    1. 建立你自己的运行时目录。通常，你会用 'runtimepath' 选项的第一项。Unix 上
"       的例子: 
"         :!mkdir ~/.vim

"    2. 创建包含自动命令的文件用于检测文件类型。示例:
"         " my filetype file
"         if exists("did_load_filetypes")
"           finish
"         endif
"         augroup filetypedetect
"           au! BufRead,BufNewFile *.mine         setfiletype mine
"           au! BufRead,BufNewFile *.xyz          setfiletype drawing
"         augroup END
"     在用户运行时目录下，把该文件存为 "filetype.vim"。例如，在 Unix 上:
"       :w ~/.vim/filetype.vim
"
"   3. 要使用新的文件类型检测，你需要重新启动 Vim。
"
"   这里，你的 filetype.vim 会在缺省的 FileType 自动命令安装前被执行。所以，你
"   的自动命令会先被匹配，而 ":setfiletype" 命令的时候保证了其后没有其他的自动
"   命令会改变 'filetype'。
"   
"   说明:在windows中，.vim对应地目录时相应的 vimfiles/目录
"   显示当前的文件类型： :set filetype
"
" 更多相关帮助见 (*43.2*  添加一个文件类型)
" http://man.chinaunix.net/newsoft/vi/doc/usr_43.html#43.2
"
" 同一个文件可以被设置为多个文件类型, 如下所示，用点号隔开:
" au BufRead,BufNewFile *.php set filetype=php.html

"" 1. 查看当前的runtimepath， :set runtimepath
"" 2. 打开一个文件时会自动检测文件的类型，Vim 会在每一个 'runtimepath'
""    列出的目录中按顺序查找 "filetype.vim"并执行set filetype
"" 3. filetype以第一次设置为准，后面的设置不起作用

if exists("did_load_filetypes")
  finish
endif


function! SetHamlSpace()
  ":match SpellBad /^\s\+/
endfunction


augroup filetypedetect
  autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
  au! FileType ruby,eruby,yaml,cucumber call g:SetTab(1, 2)
  au! FileType haml call SetHamlSpace()
  au! BufRead,BufNewFile *.test           setfiletype tcl
  au! BufRead,BufNewFile *.tpl            setfiletype php
  au! BufRead,BufNewFile *.json           setfiletype json
  au! BufRead,BufNewFile *_spec.rb        set filetype=ruby.spec
  au! BufNewFile,BufRead *.as  setf actionscript 
  au! BufEnter,BufRead,BufNewFile *.vim   set filetype=vim
  au! BufEnter,BufRead,BufNewFile *.txt  set syntax=txt 
  au BufWritePost *.coffee silent CoffeeMake!
  au BufWritePost *.coffee :CoffeeCompile watch vert
augroup END

