def color(txt)
   "\033[4;31;40m#{txt}\033[0m" 
end

#puts "love#" + color("this is really good")  + "#love"


def colord txt, atr, fg, bg
  "\033[#{atr};#{fg};#{bg}m#{txt}\033[0m" 
end

