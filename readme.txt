3. install command-t(if you use rvm)
first make sure the "rvm system --default", let the system ruby version to
install the command-t
         


Now any plugins you wish to install can be extracted to a subdirectory under ~/.vim/bundle, and they will be added to the 'runtimepath'. 

Use :Helptags to run :helptags on every doc/ directory in your 'runtimepath'. 

If you really must use one:

:e name.vba
:!mkdir ~/.vim/bundle/name
:UseVimball ~/.vim/bundle/name
