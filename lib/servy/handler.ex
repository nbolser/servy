defmodule Servy.Handler do
  require Logger

  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> emojify
    |> track
    |> format_response
  end

  def track(%{ status: 404, path: path } = conv) do
    Logger.warn "Warning: #{path} is unauthorized"
    conv
  end

  def track(conv), do: conv

  def log(conv), do: IO.inspect(conv)

  def rewrite_path(%{ path: path } = conv) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path(conv), do: conv

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

<<<<<<< Updated upstream
  def rewrite_path(conv) do
    %{ conv | path: String.replace(conv.path, "?id=", "/")}
  end

  def rewrite_path(%{ path: "/vehiclos" } = conv) do
    %{ conv | path: "/vehicles" }
=======
  def rewrite_path_captures(conv, %{"thing" => thing, "id" => id}) do
    %{ conv | path: "/#{thing}/#{id}"}
>>>>>>> Stashed changes
  end

  def rewrite_path_captures(conv, nil), do: conv

  def route(%{ method: "GET", path: "/vehicles" } = conv) do
    %{ conv | status: 200, resp_body: "Cars, Trucks, Buses" }
  end

  def route(%{ method: "GET", path: "/cars" } = conv) do
    %{ conv | status: 200, resp_body: "Toyota, Jeep, Fiat" }
  end

  def route(%{ method: "GET", path: "/cars/" <> id } = conv) do
    %{ conv | status: 200, resp_body: "Car #{id}" }
  end

  def route(%{ method: "DELETE", path: "/cars/" <> _id } = conv) do
    %{ conv | status: 403, resp_body: "Deleting car is forbidden" }
  end

  def route(%{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "Path #{path} not available."}
  end

  def emojify(%{ status: 200 } = conv) do
    %{ conv | status: String.duplicate("👍", 5) }
  end

  def emojify(conv), do: conv

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

request = """
GET /vehiclos HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /bears?id=1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
<<<<<<< Updated upstream
response = Servy.Handler.handle(request)

IO.puts response
=======

response = Servy.Handler.handle(request)
>>>>>>> Stashed changes
