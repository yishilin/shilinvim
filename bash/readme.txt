== this will help to setup your linux/unix env with:
==  - vim, zsh, ag, shilin's alias


remove(){
  file=$1
  echo "rm -f $file"
  [ -f "$file" ] && rm -f $file
  [ -d "$file" ] && rm -r -f $file
}

0. make Generating SSH Keys for github for your account:
https://help.github.com/articles/generating-ssh-keys

1. install vim configuration:
  cd /local/github
  git clone git@github.com:yishilin/shilinvim.git #this will create ./shilinvim/ dir
  VIM_DIR=$PWD/shilinvim
  remove ~/.vim
  ln -s $VIM_DIR/vim/ ~/.vim
  remove ~/.vimrc
  ln -s $VIM_DIR/_vimrc ~/.vimrc

2. install zsh
remove ~/.oh-my-zsh
1.) normally (mac ect.)
https://github.com/robbyrussell/oh-my-zsh

2.) special case [ubuntu]
http://monangik.wordpress.com/2011/04/21/install-zsh-shell-on-ubuntu/
https://gist.github.com/tsabat/1498393 :

sudo apt-get update && sudo apt-get install zsh
wget –no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O – | sh
chsh -s `which zsh`
sudo shutdown -r 0

3). configure zshrc

remove ~/.zshrc
remove ~/.shilinvim
ln -s $VIM_DIR/bash/zshrc ~/.zshrc
ln -s $VIM_DIR/bash/shilin_alias ~/.shilin_alias
ln -s $VIM_DIR/bash/shilin.zsh-theme ~/.oh-my-zsh/themes/shilin.zsh-theme

3. install ag:
https://github.com/ggreer/the_silver_searcher
