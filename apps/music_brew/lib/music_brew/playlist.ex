defmodule MusicBrew.PlayList do
  def create_playlist() do
      Heap.new(&(Map.fetch!(&1, :rank) > Map.fetch!(&2, :rank)))
  end

  def new_playList() do
    create_playlist()
  end

  def add_song(playlist , %{rank: rank, title: title, id: id}) when is_list(playlist) do
     [%{rank: rank, title: title, id: id} | playlist]
    |> sort_playlist
  end

  def inc_song(playlist, index) when is_list(playlist) and is_integer(index) do
    song = Enum.at(playlist, index)
    update_song_at_index(playlist, index, %{song | rank: song.rank + 1})
  end


  def dec_song(playlist, index) when is_list(playlist) do
    song = Enum.at(playlist, index)
    update_song_at_index(playlist, index, %{song | rank: song.rank - 1})
  end

  defp update_song_at_index(playlist, index, song) do
    playlist
    |> List.replace_at(index, song)
    |> sort_playlist()
  end



  defp sort_playlist(playlist) when is_list(playlist), do: Enum.sort(playlist, &(&1.rank >= &2.rank))
end
