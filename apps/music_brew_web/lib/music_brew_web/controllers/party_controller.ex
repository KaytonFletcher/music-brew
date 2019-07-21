defmodule MusicBrewWeb.PartyController do
  use MusicBrewWeb, :controller
  alias Phoenix.LiveView

  def index(conn, %{"id" => party_id}) do
    LiveView.Controller.live_render(conn, MusicBrewWeb.PartyView, session: %{party_id: party_id})
  end
end
