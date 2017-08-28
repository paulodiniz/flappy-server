defmodule FlappyServer.PageController do
  use FlappyServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
