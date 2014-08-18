#!ruby


# Vim ruby extend for executing shell command asyn.
# Author: y****lin@gmail.com
# v1.0

require 'socket' 

class AsyncCommandBase
    @@is_win = RUBY_PLATFORM.downcase =~ /mswin(?!ce)|mingw|cygwin|bccwin/
    @@socket_path = ENV['RSENSE_SOCKET'] 
    @@host = nil
    @@port = nil

    unless @@socket_path
      if @@is_win
        @@socket_path = 'localhost:77367'
      else
        @@socket_path = '/tmp/rsense-socket'
      end
    end
    if @@socket_path =~ /^(\w+):(\d+)+$/
      @@host = $1
      @@port = $2.to_i
    end

    def self.time_header
        t = Time.now
        t.strftime("%Y/%m/%d %H:%M:%S")
    end
end


class AsyncCommandClient < AsyncCommandBase
    def self.open_client(&block)
        if @@host
            TCPSocket.open(@@host, @@port, &block)
        else
            UNIXSocket.open(@@socket_path, &block)
        end
    end 

    #api, AsyncCommandClient.send_command("ls ~")
    #     AsyncCommandClient.send_command("ls" "~")
    def self.send_command(*command)
        argv = Array(command)
        if argv[0] == 'stop'
          argv = ['stop']
        end
        open_client {|sock|
          sock.puts(argv.join(' '))
          sock.close
        }
    end 
end



class AsyncCommandServer < AsyncCommandBase

    def self.daemonize
      if Process.respond_to? :daemon  # Ruby 1.9
        Process.daemon
      else                            # Ruby 1.8
        require 'webrick'
        WEBrick::Daemon.start
      end
    end
    
    def self.open_server(&block)
      if @@host
        TCPServer.open(@@host, @@port, &block)
      else
        UNIXServer.open(@@socket_path, &block)
      end
    end
    
    def self.close_server
      File.unlink(@@socket_path) rescue nil unless @@host
    end
    
    
    def self.server_process
      begin
        open_server do |serv|
          begin
            puts "#{time_header} command schedule server started: #{@@host ? (@@host + ':' + @@port.to_s) : @@socket_path} (#{$$})"
            loop do
              begin
                sock = serv.accept
                cmd = sock.gets
                command_process(cmd)
                if cmd =~ /^(stop|exit|quit)/
                  puts "stop"
                  sock.close
                  close_server
                  return
                end
                sock.close_read
              rescue Errno::EPIPE, Errno::ECONNRESET
              end
            end
          ensure
            puts "stop"
            close_server
          end
        end
      ensure
        exit
      end
    end
    
    
    def self.command_process(command)
        Thread.new(command) do |cmd|
            cmd = cmd.chop!
            puts "\n\n+++++++++++++++++++++++++++++++++++++++++++" 
            puts "command=> #{time_header}"
            puts "#{color(cmd)}"
            puts "---------------------------------" 
            system cmd 
            puts "---------------------------------" 
            puts "command ##{cmd} \nover.\n\n"
            system "\n"
        end 
    end
    
    def self.start_server
        close_server
        server_process
    end

    def self.color(txt)
       "\033[4;31;40m#{txt}\033[0m" 
    end 
end

#Usage:

#AsyncCommandClient.send_command("pwd")
#AsyncCommandClient.send_command("ls", ".")
#AsyncCommandServer.start_server

