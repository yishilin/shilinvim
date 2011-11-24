#!ruby

current_dir = File.dirname(__FILE__)
plugin_file_no_extern = "#{current_dir}/asyn_cmd"
asyn_cmd_file = plugin_file_no_extern + ".rb"
if !File.file?(asyn_cmd_file)
  puts "error: file #{asyn_cmd_file} is not exist !"
  exit(1)
end
require plugin_file_no_extern
AsyncCommandServer.start_server
