require 'socket'
require_relative './lib/parser.rb'
require_relative './lib/response.rb'

ROOT = './files'
server_socket = TCPServer.new(12000)

while true
  puts "Ready to serve..."
  Thread.start(server_socket.accept) do |connection_socket|
    message = connection_socket.recv(1024)
    parsed = Parser.new(message)
    filename = parsed.message[:path] == "/" ? ROOT + "/index.html" : ROOT + parsed.message[:path]
    response = Response.new(filename)
    connection_socket.puts response.message
  end
end
