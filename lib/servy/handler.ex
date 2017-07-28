defmodule Servy.Handler do
  def handler(request) do
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handler(request)

IO.puts response
