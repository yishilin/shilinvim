
# Overview
Setup the vim in linux/unix env

# Install steps


```shell
# TODO: change it to your directory path!
INSTALL_PATH=/local/github

do_remove(){
  file=$1
  echo "rm -f $file"
  [ -f "$file" ] && rm -f $file
  [ -d "$file" ] && rm -r -f $file
}

cd $INSTALL_PATH

#below will create ./shilinvim/ dir
git clone https://github.com/yishilin/shilinvim.git

VIM_DIR=$PWD/shilinvim
do_remove ~/.vim
ln -s $VIM_DIR/vim/ ~/.vim
do_remove ~/.vimrc
ln -s $VIM_DIR/_vimrc ~/.vimrc

cd $VIM_DIR
git config --global core.excludesfile ~/.gitignore

# update git submodule vim plugin
git pull origin master
git submodule init
git submodule update
git submodule foreach git pull origin master
```


# ctags (mac)
brew install ctags

you may need to update  g:Tlist_Ctags_Cmd in vim/vimrc.vim file

# snipmate
see https://github.com/garbas/vim-snipmate

#  command-t (if you use rvm)
First make sure the "rvm system --default", let the system ruby version to install the command-t 


# vim bundle

Now any plugins you wish to install can be extracted to a subdirectory under ~/.vim/bundle, and they will be added to the 'runtimepath'. 

Use :Helptags to run :helptags on every doc/ directory in your 'runtimepath'. 

If you really must use one:

```shell
:e name.vba
:!mkdir ~/.vim/bundle/name
:UseVimball ~/.vim/bundle/name
```


# Add git submudule as vim plugin

下面以 vim-rails 为例：

```shell
# this will update .gitmodules:
git submodule add https://github.com/tpope/vim-rails.git vim/bundle/vim-rails

# sometime you need to:
git rm --cached vim/bundle/vim-rails
```

