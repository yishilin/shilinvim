 " Vim global plugin for executing shell command asyn.
 " Author: yishilin@gmail.com
 " v1.0

"" Install:
"" you need include the ruby/asyn_cmd.rb file.
"" Usage:
"" 1.)start server(commandline) 
""   $ruby ruby/asyn_server_start.rb 
"" 2.)in your vim, 
""   :call g:AsynCommand("ls -l")
""   :call g:AsynCommand("exit")

if has("ruby")

" Check if the plugin was already loaded
if exists('asyn_cmd') 
	finish
endif
let asyn_cmd = 1

function! g:AsynCommand(command)

ruby << RUBYCODE
  command = VIM.evaluate("a:command")
  vim_plugin_path = VIM.evaluate("$VIM_PLUGIN") + "/bundle/async_cmd"
  plugin_file_no_extern = "#{vim_plugin_path}/ruby/asyn_cmd"
  asyn_cmd_file = plugin_file_no_extern + ".rb"
  if !File.file?(asyn_cmd_file)
    puts "error: file #{asyn_cmd_file} is not exist !"
	return
  end
  require plugin_file_no_extern
  AsyncCommandClient.send_command(command)
RUBYCODE

endfunction



function! g:AsynCommandServerStart()
ruby << RUBYCODE
  vim_plugin_path = VIM.evaluate("$VIM_PLUGIN")
  plugin_file_no_extern = "#{vim_plugin_path}/ruby/asyn_cmd"
  asyn_cmd_file = plugin_file_no_extern + ".rb"
  if !File.file?(asyn_cmd_file)
    puts "error: file #{asyn_cmd_file} is not exist !"
	return
  end
  require plugin_file_no_extern
  AsyncCommandServer.start_server
RUBYCODE

endfunction

endif
