defmodule MusicBrewWeb.PartyChannel do
  use Phoenix.Channel

  def join("party:" <> _party_id, _params, socket) do
    {:ok, socket}
  end

end
