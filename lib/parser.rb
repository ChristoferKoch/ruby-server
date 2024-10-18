class Parser
  attr_reader :message
  
  def initialize(message)
    first_line = message.lines[0].split
    @message = {
      method: first_line[0],
      path: first_line[1],
      version: first_line[2],
      headers: get_headers(message.lines[1..-1])
    }
  end

  def get_headers(header_text)
    headers = {  }
    header_text.each do |line|
      return headers unless line != "\r\n"
      symbol, text = line.split
      symbol = symbol.sub(':', '').downcase.to_sym
      headers[symbol] = text
    end
  end
end
