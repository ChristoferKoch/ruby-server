require 'socket'
require_relative './lib/parser.rb'

server_socket = TCPServer.new(12000)

server_socket.listen(1)

while true
  puts "Ready to serve..."
  Thread.start(server_socket.accept) do |connection_socket|
    begin
      message = connection_socket.recv(1024)
      parsed_message = Parser.new(message)
      filename = parsed_message.message[:path]
      f = File.open('.' + filename)
    rescue Errno::ENOENT
      connection_socket.puts "HTTP/1.1 404 Not Found\r\n\r\n"
    else
      output_data = f.read
      connection_socket.puts "HTTP/1.1 200 OK\r\n\r\n" + output_data + "\r\n"
    end
  end
end
