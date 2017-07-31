defmodule Servy.Handler do
  def handle(request) do
  	request 
  	|> parse
    |> log
  	|> route 
  	|> format_response
  end

  def log(conv), do: IO.inspect(conv)

  def parse(request) do
  	[method, path, _] =
  		request 
  		|> String.split( "\n") 
  		|> List.first
  		|> String.split(" ")

  	%{
      method: method,
      path: path,
      resp_body: "",
      status: nil
    }
  end

  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/vehicles") do
    %{ conv | status: 200, resp_body: "Cars, Trucks, Buses" }
  end

  def route(conv, "GET", "/cars") do
    %{ conv | status: 200, resp_body: "Toyota, Jeep, Fiat" }
  end

  def route(conv, "GET", "/cars/" <> id) do
    %{ conv | status: 200, resp_body: "Car #{id}" }
  end

  def route(conv, "DELETE", "/cars/" <> _id) do
    %{ conv | status: 403, resp_body: "Deleting car is forbidden" }
  end

  def route(conv, _method, path) do
    %{ conv | status: 404, resp_body: "Path #{path} not available."}
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
    
  end
end

request = """
GET /vehicles HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /cars HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /foo HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /cars/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response