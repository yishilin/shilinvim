# Overview
Setup the vim in Windows/Linux/Mac env


# Install steps for windows 10

1) install git

https://git-scm.com/download/win

2) clone and install git module:


```
cd C:/Software/shilinvim
git clone --recurse-submodules -j8 https://github.com/yishilin/shilinvim.git

git config --global core.excludesfile ~/.gitignore
git submodule foreach git pull origin master #optional, used when update submodule

```

3) vim $HOME/\_vimrc

```
let g:VIM_GIT_CONF_PATH = "C:/Software/shilinvim"
source C:/Software/shilinvim/_vimrc
```


4) install font

5) put ctags into $VIM/

# Install steps mac


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
git clone --recurse-submodules -j8 https://github.com/yishilin/shilinvim.git

git config --global core.excludesfile ~/.gitignore
git submodule foreach git pull origin master #optional, used when update submodule

VIM_DIR=$PWD/shilinvim
do_remove ~/.vim
ln -s $VIM_DIR/vim/ ~/.vim
do_remove ~/.vimrc
ln -s $VIM_DIR/_vimrc ~/.vimrc

cd $VIM_DIR
git config --global core.excludesfile ~/.gitignore

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

cd $VIM_GIT_ROOT_DIR
git submodule init

# this will update .gitmodules file:
git submodule add https://github.com/tpope/vim-rails.git vim/bundle/vim-rails

# sometime you need to:
git rm --cached vim/bundle/vim-rails
```

Then in vim:
:Helptags


# Update plugin
With Git, with or without submodules:
```
$ cd bundle/delimitMate-master
$ git pull
```



# Remove plugin
With Git, using submodules:

```
$ cd $VIM_GIT_ROOT_DIR
$ git submodule deinit -f vim/bundle/delimitMate
$ git rm -rf vim/bundle/delimitMate
$ rm -rf .git/modules/bundle/delimitMate
```

