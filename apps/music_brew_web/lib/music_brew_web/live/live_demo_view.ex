defmodule MusicBrewWeb.LiveDemoView do
  use Phoenix.LiveView

  @up_key " "
  @down_key 40


  def render(assigns) do
    MusicBrewWeb.PageView.render("demo.html", assigns)
  end


  def mount(_session, socket) do
    {:ok, assign(socket, message: "Ready!", playlist: [],
    library: [ %{title: "That Green Gentlemen", artist: "Panic at the disco"},
    %{title: "Thank you for the venom", artist: "My Chemical Romance"}
    ])}
  end

  # def handle_event("song_value_inc", , socket) do
  #   {:noreply, assign(socket, playlist: Enum.sort(socket.assigns.playlist))}
  # end

  def handle_event("add_song_to_playlist", title, socket) do
    {:noreply, assign(socket, playlist: [ %{title: title, rank: 0} | socket.assigns.playlist ]  ) }
  end

  def handle_event("send_message", _key, socket) do
    {:noreply, socket}
  end
end
