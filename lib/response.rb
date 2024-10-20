class Response
  attr_reader :message
  
  def initialize(file_path)
    code, status_message = get_response_code(file_path)
    output_data = code == 200 ? File.binread(file_path) + "\r\n" : ""
    @message = "HTTP/1.1 #{code} #{status_message}\r\n\r\n#{output_data}"
  end

  def get_response_code(path)
    code = File.exist?(path) ? 200 : 404
    message = get_response_message(code)
    [code, message]
  end

  def get_response_message(code)
    # Incomplete list. Update as errors are dealt with.
    message =
      case code
      when 200
        "OK"
      when 201
        "Created"
      when 301
        "Moved Permanently"
      when 302
        "Found"
      when 304
        "Not Modified"
      when 307
        "Temporary Redirect"
      when 308
        "Permanent Redirect"
      when 400
        "Bad Request"
      when 401
        "Unauthorized"
      when 402
        "Payment Required"
      when 403
        "Forbidden"
      when 404
        "Not Found"
      when 500
        "Internal Server Error"
      end
  end
end
