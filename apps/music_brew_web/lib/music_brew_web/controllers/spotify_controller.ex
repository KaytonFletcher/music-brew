defmodule MusicBrewWeb.SpotifyController do
  use MusicBrewWeb, :controller

  def authorize(conn, _params) do
    conn |>
    redirect(external: MusicBrew.Spotify.get_authorize_url())
  end

  def authenticate(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn } ->
        #CHANGE FROM 48 TO RANDOM NUMBER
        redirect conn, to: Routes.party_path(conn, :index, 48)
      { :error, reason, conn } ->
        IO.puts(reason)
        authorize(conn, params)
    end
  end
end
