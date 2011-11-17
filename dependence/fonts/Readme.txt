1. font setup:
windows: copy font files(*.ttf) to dir:  %windir%\fonts
  "---------------------------------------------
  "_vimrc font setting
  "----------------------------------
  "set guifont=ProggyClean:h13:w7.5:cDEFAULT
  "set guifont=MONACO:h9:w7:cDEFAULT
  "set guifont=Fixedsys:h9:w7:cDEFAULT
  set guifont=Consolas:h12:cDEFAULT
  "---------------------------------------------

linux: 
(1).copy fonts to /usr/share/fonts/zh_CN/TrueType/
(2).cd /usr/share/fonts/zh_CN/TrueType/
     mkfontdir
     mkfontscale 
     fc-cache -v -f
(3).reset your gui(ctrl-alt-backspace)




2.font setting
(1).ProggyClean.ttf
The ProggyClean.ttf contains the Latin-1 character set (ISO 8859-1 I think)
The ProggyCleanCE.ttf can be used for the Czech language, but I assume it's just
Latin-2, so you can try it if the caracters you want are missing... and you can read
English enough to understand this readme :)

(2).Fixedsys.ttf
Font sizes
You¡äll often find that font size 11 gives the best results
When using Java try font size 15 (Windows) or 14 (Linux?).
