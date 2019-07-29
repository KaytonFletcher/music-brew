defmodule MusicBrewWeb.PartyChannel do
  use Phoenix.Channel
  def join("event_bus:" <> _chat_id, _message, socket) do
    Registry.register(Registry.SessionRegistry, socket.assigns.session_uuid, self())
    {:ok, socket}
  end


  #Sends messages to client live view channel
  def handle_info(msg, socket) do
    push(socket, msg, %{})
    {:noreply, socket}
  end

  #Recieves message from client's music player
  def handle_in("remove_song", %{ "partyId" => partyId}, socket) do
    IO.puts("handling song removal")
    MusicBrewWeb.Endpoint.broadcast_from!(self(), "party:#{partyId}", "remove_song", %{})
    {:noreply, socket}
  end

end
