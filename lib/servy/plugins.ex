defmodule Servy.Plugins do
  require Logger

  @doc "Logs 404 requests"
  def track(%{ status: 404, path: path } = conv) do
    Logger.warn "Warning: #{path} is unauthorized"
    conv
  end

  def track(conv), do: conv

  def rewrite_path(%{ path: "/vehiclos" } = conv) do
    %{ conv | path: "/vehicles" }
  end

  def rewrite_path(conv), do: conv

  def log(conv), do: IO.inspect(conv)
end
