defmodule Servy.Handler do
  def handle(request) do
  	request 
  	|> parse 
  	|> route 
  	|> format_response
  end

  def parse(request) do
    # TODO: Parse the request string into a map:
    conv = %{ method: "GET", path: "/vehicles", resp_body: "" }
  end

  def route(conv) do
    # TODO: Create a new map that also has the response body:
    conv = %{ method: "GET", path: "/vehicles", resp_body: "Cars, Trucks, Buses" }
  end

  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Cars, Trucks, Buses
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response
