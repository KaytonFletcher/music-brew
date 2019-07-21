defmodule MusicBrewWeb.PartyView do
  use Phoenix.LiveView
  import MusicBrew.PlayList

  defp topic(party_id), do: "party:#{party_id}"

  def render(assigns) do
    MusicBrewWeb.PageView.render("demo.html", assigns)
  end

  def mount(%{party_id: party_id}, socket) do

    MusicBrewWeb.Endpoint.subscribe(topic(party_id))
    {:ok, assign(socket, party_id: party_id, playlist: [],
    library: [ %{title: "That Green Gentlemen", artist: "Panic at the disco"},
    %{title: "Thank you for the venom", artist: "My Chemical Romance"}
    ])}
  end

  def handle_event("inc_song_rank", index, socket) do
    playlist = inc_song(socket.assigns.playlist, String.to_integer(index))
    MusicBrewWeb.Endpoint.broadcast_from(self(), topic(socket.assigns.party_id), "playlist_updated", %{playlist: playlist})
    {:noreply, assign(socket, playlist: playlist)}
  end

#FOR ERROR CHECKING CONVERT String.to_integer() to Integer.parse()
  def handle_event("dec_song_rank", index, socket) do

    playlist = dec_song(socket.assigns.playlist, String.to_integer(index))
    MusicBrewWeb.Endpoint.broadcast_from(self(), topic(socket.assigns.party_id), "playlist_updated", %{playlist: playlist})
    {:noreply, assign(socket, playlist: playlist)}
  end

  def handle_event("add_song_to_playlist", title, socket) do
    playlist = add_song(socket.assigns.playlist, %{title: title, rank: 0, id: Enum.random(0..100000)})
    MusicBrewWeb.Endpoint.broadcast_from(self(), topic(socket.assigns.party_id), "playlist_updated", %{playlist: playlist})
    {:noreply, assign(socket, playlist: playlist)}
  end

  def handle_info(%{event: "playlist_updated", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

end
