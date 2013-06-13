
== this will help to setup your linux/unix env with vim


remove(){
  file=$1
  echo "rm -f $file"
  [ -f "$file" ] && rm -f $file
  [ -d "$file" ] && rm -r -f $file
}

0. make Generating SSH Keys for github for your account:

0.1) install git and generate the ssh key: ~/.ssh/id_rsa.pub
https://help.github.com/articles/set-up-git
https://help.github.com/articles/generating-ssh-keys
https://confluence.atlassian.com/display/BITBUCKET/Set+up+SSH+for+Git

0.2) add the ssh key ~/.ssh/id_rsa.pub into the github and bitbucket:
https://bitbucket.org/account/user/sorry123/ssh-keys/
https://github.com/settings/ssh




1. install vim configuration:
cd /local/github
git clone git@github.com:yishilin/shilinvim.git #this will create ./shilinvim/ dir
VIM_DIR=$PWD/shilinvim
remove ~/.vim
ln -s $VIM_DIR/vim/ ~/.vim
remove ~/.vimrc
ln -s $VIM_DIR/_vimrc ~/.vimrc



2. install command-t(if you use rvm)
first make sure the "rvm system --default", let the system ruby version to
install the command-t

Now any plugins you wish to install can be extracted to a subdirectory under ~/.vim/bundle, and they will be added to the 'runtimepath'. 

Use :Helptags to run :helptags on every doc/ directory in your 'runtimepath'. 

If you really must use one:

:e name.vba
:!mkdir ~/.vim/bundle/name
:UseVimball ~/.vim/bundle/name


3.  add an vim plugin git repo as a git submodule:
0.) cdvim
git config --global core.excludesfile ~/.gitignore

1.) git submodule add https://github.com/tpope/vim-rails.git vim/bundle/vim-rails
this will update .gitmodules
sometime you need to:
git rm --cached vim/bundle/vim-rails

4. how to install the submodule
see ./.gitmodules
git submodule init
git submodule update

5. remember to run ./update.sh

6. for snipmate, see https://github.com/garbas/vim-snipmate


