defmodule MusicBrewWeb.PageController do
  use MusicBrewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
