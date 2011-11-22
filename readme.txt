1. how to install in unix:
  cd /local/github/shilinvim
  git clone git@github.com:yishilin/yislvim.git #this will create ./yislvim/ dir
  git remote add origin git@github.com:yishilin/yislvim.git
  cd ~
  ln -s /local/yisl/yislvim/Vim/vimfiles/ .vim
  ln -s /local/yisl/yislvim/Vim/_vimrc .vimrc

2. install command-t(if you use rvm)
first make sure the "rvm system --default", let the system ruby version to
install the command-t
         
