defmodule MusicBrewWeb.PartyView do
  use Phoenix.LiveView
  import MusicBrew.PlayList

  def render(assigns) do
    MusicBrewWeb.PageView.render("demo.html", assigns)
  end


  def mount(_session, socket) do
    {:ok, assign(socket, message: "Ready!", playlist: create_playlist(),
    library: [ %{title: "That Green Gentlemen", artist: "Panic at the disco"},
    %{title: "Thank you for the venom", artist: "My Chemical Romance"}
    ])}
  end

  # def handle_event("song_value_inc", , socket) do
  #   {:noreply, assign(socket, playlist: Enum.sort(socket.assigns.playlist))}
  # end

  def handle_event("inc_song_rank", index, socket) do
    {:noreply, assign(socket, playlist: inc_song(socket.assigns.playlist, index))}
  end


  def handle_event("dec_song_rank", index, socket) do
    {:noreply, assign(socket, playlist: dec_song(socket.assigns.playlist, index))}
  end


  def handle_event("add_song_to_playlist", title, socket) do
    {:noreply, assign(socket, playlist: add_song(socket.assigns.playlist, %{title: title, rank: 0, id: Enum.random(0..100000) })  ) }
  end

  def handle_event("send_message", _key, socket) do
    {:noreply, socket}
  end
end
