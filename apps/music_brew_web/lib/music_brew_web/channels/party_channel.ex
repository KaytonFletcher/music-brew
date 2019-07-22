defmodule MusicBrewWeb.PartyChannel do
  use Phoenix.Channel
  def join("event_bus:" <> _chat_id, _message, socket) do
    Registry.register(Registry.SessionRegistry, socket.assigns.session_uuid, self())
    {:ok, socket}
  end

  def handle_info(msg, socket) do
    IO.puts("HANDLING NEW MESSAGE")
    push(socket, msg, %{})
    {:noreply, socket}
  end

end
