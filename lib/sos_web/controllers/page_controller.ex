defmodule SosWeb.PageController do
  use SosWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
