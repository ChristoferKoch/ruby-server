require 'socket'

server_socket = TCPServer.new(12000)
p server_socket

server_socket.listen(1)

while true
  puts "Ready to serve..."
  connection_socket = server_socket.accept
  begin
    message = connection_socket.recv(1024)
    filename = message.split[1]
    f = File.open('.' + filename)
  rescue Errno::ENOENT
    connection_socket.puts "HTTP/1.1 404 Not Found\r\n\r\n"
  else
    output_data = f.read
    connection_socket.puts "HTTP/1.1 200 OK\r\n\r\n" + output_data + "\r\n"
  end
  
end
