defmodule MusicBrew.Library do
  def getTracks(spotify_creds) do
    tracks = case Spotify.Library.get_saved_tracks(spotify_creds) do
      {:ok, tracks} -> tracks.items
      {:error, msg} -> IO.puts(msg)
    end

    tracks
    |> Enum.map(fn track -> Map.take(track, [:id, :name, :artists, :uri]) end)
  end

  def getSongById(spotify_creds, id) do
    track = case Spotify.Track.get_track(spotify_creds, id) do
      {:ok, track} -> track
      {:error, msg} -> IO.puts(msg)
    end

    Map.take(track, [:id, :name, :artists, :uri])
  end

end
