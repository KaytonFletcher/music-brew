defmodule MusicBrewWeb.PartyController do
  use MusicBrewWeb, :controller
  alias Phoenix.LiveView

  def index(conn, %{"id" => party_id}) do
    session_uuid = Ecto.UUID.generate()
    LiveView.Controller.live_render(conn,  MusicBrewWeb.PartyLive, session: %{access_token: conn.cookies["spotify_access_token"], party_id: party_id, session_uuid: session_uuid})
  end
end
