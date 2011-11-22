

要正确使用所有这些插件，前提：


1. fonts setup


2. ctags.exe(windows中)
copy ctags.exe to $VIMRUNTIME/ 


3. 要安装cscope,则必须要有cscope扩展支持
在vim中:version, 输出中一定有+cscope


4. fuzzyfinder_textmate.vim安装 ( need vim(+ruby) )
 (1) vim必须有 ruby扩展,在vim中:version, 输出中一定有 +ruby或+ruby/dyn
 (2) 必须先安装ruby1.86,再安装gvim, http://github.com/jamis/fuzzyfinder_textmate/tree/master
 说明:为什么要ruby1.86? 可打开gvim.exe查看:
   -DFEAT_RUBY -DDYNAMIC_RUBY -DDYNAMIC_RUBY_VER=18 -DDYNAMIC_RUBY_DLL=\"msvcrt-ruby18.dll\"


5. 建立 $HOME/vim_tmp 和 $HOME/vim_backup 文件夹
在vim中使用命令:echo $HOME 查看$HOME

6. grep.vim依赖于
  http://gnuwin32.sourceforge.net/packages/grep.htm
  http://gnuwin32.sourceforge.net/packages/findutils.htm
  http://www.tgries.de/agrep/

7. ack.vim依赖于ack
   http://eshilin.blog.163.com/blog/static/132880330201101962214262/

-----------------------------------------------


vim 编译(linux):

 [ 下载vim源代码 ]

7.1主要有两个包 vim-7.1.tar.bz2， vim-7.1-lang.tar.gz （多国语言包)

前者是bz2格式的，用 tar xvfj vim-7.1.tar.bz2 解压 ( j表示解压bz2)
后者用  tar xzvf vim-7.1.lang.tar.gz 解压

 [ 定制vim的功能 ]

缺省的vim配置已经适合大多数人，但有些时候你可能需要一些额外的功能，这时就需要自己定制一下vim。
定制vim很简单，进入~/install/vim71/src文件，编辑Makefile文件。这是一个注释很好的文档，根据注释来选择：

    * 如果你不想编译gvim，可以打开–disable-gui选项；
    * 如果你想把perl, python, tcl, ruby等接口编译进来的话，打开相应的选项，例如，我打开了–enable-tclinterp选项；
    * 如果你想在vim中使用cscope的话，打开–enable-cscope选项；
    * 我们刚才打的vimgdb补丁，自动在Makefile中加入了–enable-gdb选项；
    * 如果你希望在vim使用中文，使能–enable-multibyte和–enable-xim选项；
    * 可以通过–with-features=XXX选项来选择所编译的vim特性集，缺省是–with-features=normal；
    * 如果你没有root权限，可以把vim装在自己的home目录，这时需要打开prefix = $(HOME)选项； 

编辑好此文件后，就可以编辑安装vim了。如果你需要更细致的定制vim，可以修改config.h文件，打开/关闭你想要的特性。 

注：我们更推荐个方式：
./configure --with-features=huge \
--enable-cscope \
--enable-multibyte \
--enable-xim \
--enable-fontset \
--enable-gui=gnome2

解释下:
huge 我想就是大而全，先加这个选项再说，免得漏了什么功能
  可以选择的还有tiny，small，normal，big
multibyte 多字节支持
xim 输入法支持
fontset 字体设置
perlinterp 如需要嵌入perl
pythoninterp 如需要嵌入python
disable-gui 我不需要gui的界面，关闭

注意config时如果前面进行过，会在src/auto/config.cache中保留，再次配置时应该删除这个文件。



 [ 编译安装 ]

编译和安装vim非常简单，使用下面两个命令：

make
make install 

你不需要手动运行./configure命令，make命令会自动调用configure命令。

上面的命令执行完后，vim就安装成功了。

我在编译时打开了”prefix = $(HOME)”选项，因此我的vim被安装在~/bin目录。这时需要修改一下PATH变量，以使其找到我编辑好的vim。在~/.bashrc文件中加入下面这两句话：

PATH=$HOME/bin:$PATH
export PATH 

退出再重新登录，现在再敲入vim命令，发现已经运行我们编译的vim了。 




http://sourceforge.net/projects/ctags/
http://svn.ruby-lang.org/
http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/branches/ruby_1_8_6/

