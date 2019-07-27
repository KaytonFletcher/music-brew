defmodule MusicBrewWeb.PartyLive do
  use Phoenix.LiveView
  import MusicBrew.PlayList

  # @library [%{title: "That Green Gentlemen", artist: "Panic at the disco"},
  # %{title: "Thank you for the venom", artist: "My Chemical Romance"}]

  defp topic(party_id), do: "party:#{party_id}"

  def render(assigns) do
    MusicBrewWeb.PartyView.render("index.html", assigns)
  end

  def mount(%{party_id: party_id,  session_uuid: session_uuid, spotify_creds: spotify_creds}, socket) do

    MusicBrewWeb.Endpoint.subscribe(topic(party_id))
    tracks = MusicBrew.Library.getTracks(spotify_creds)

    send(self(), {:send_to_event_bus, "playlist_mounted"})
    {:ok, assign(socket,
    party_id: party_id,
    spotify_creds: spotify_creds,
    playlist: [],
    library: tracks,
    session_uuid: session_uuid,
    token: Phoenix.Token.sign(MusicBrewWeb.Endpoint, "user salt", session_uuid))}
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

  def handle_event("add_song_to_playlist", id, socket) do
    track = MusicBrew.Library.getSongById(socket.assigns.spotify_creds, id)

    playlist = add_song(socket.assigns.playlist, Map.put(track, :rank, 0))
    MusicBrewWeb.Endpoint.broadcast_from(self(), topic(socket.assigns.party_id), "playlist_updated", %{playlist: playlist})
    send(self(), {:send_to_event_bus, "playlist_updated"})
    {:noreply, assign(socket, playlist: playlist)}
  end

  #handles notifying other users in same party when playlist is updated
  def handle_info(%{event: "playlist_updated", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

  def handle_info({:send_to_event_bus, msg}, socket = %{assigns: %{session_uuid: session_uuid}}) do
    # send a message to the channel here!
    IO.puts("SENDING MESSAGE FROM PARTY VIEW")
    [{_pid, channel_pid}] = Registry.lookup(Registry.SessionRegistry, session_uuid)
    send(channel_pid, msg)
    {:noreply, socket}
  end
end
