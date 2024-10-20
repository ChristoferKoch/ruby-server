class Response
  attr_reader :response
  # Incomplete list. Update as errors are dealt with.
  RESPONSE_CODES = {
    200: "OK",
    201: "Created",
    301: "Moved Permanently",
    302: "Found",
    304: "Not Modified",
    307: "Temporary Redirect",
    308: "Permanent Redirect",
    400: "Bad Request",
    401: "Unauthorized",
    402: "Payment Required",
    403: "Forbidden",
    404: "Not Found",
    500: "Internal Server Error"
  }

  def initialize(file_path)
    code, message = get_response_code(file_path)
    output_data = code == :200 ? File.binread(file_path) + "\r\n" : ""
    @response = "HTTP/1.1 #{code} #{message}\r\n\r\n#{output_data}"
  end

  def get_response_code(path)
    code = File.exists?(path) ? :200 : :404
    message = RESPONSE_CODES[code]
    [code, message]
  end
end
