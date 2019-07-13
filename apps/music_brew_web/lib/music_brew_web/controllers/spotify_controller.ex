defmodule MusicBrewWeb.SpotifyController do
  use MusicBrewWeb, :controller
  import MusicBrew.Spotify, only: [get_authorize_route: 0, get_access_token: 1]


  def auth(conn, _params) do
    conn |>
    redirect(external: get_authorize_route())
  end

  def getAccessToken(conn, %{"code" => code}) do
    conn
    |> put_session(:access_token, code)
    |> redirect(to: Routes.spotify_path(conn, :new))
  end
  def getAccessToken(conn, _params), do: render(conn, "index.html")

  def new(conn, _params) do
    Map.get(conn.assigns, :access_token)
    |> get_access_token()
    |> IO.inspect()
    conn
    |> render("new.html")
  end
end
