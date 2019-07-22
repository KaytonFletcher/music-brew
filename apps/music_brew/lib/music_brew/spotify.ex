defmodule MusicBrew.Spotify do
  def get_authorize_url do
    Spotify.Authorization.url
  end


  # @client_id "6e5d5a5e98624a10beee2f7133f62f1d"
  # @endpoint "https://api.github.com"
  # @redirect_uri "https://localhost:4000/spotify/callback"
  # @headers = ["Authorization": "Bearer #{token}", "Content-Type": "application/json"]

  # def process_url(url) do
  #   @endpoint <> url
  # end

  # def process_headers(headers) do
  #   IO.inspect(headers)
  #   headers
  # end

  # @spec get_authorize_route :: <<_::64, _::_*8>>
  # def get_authorize_route() do
  #   scope = "user-read-private user-read-email playlist-read-private playlist-modify-private playlist-modify-public"

  #   "https://accounts.spotify.com/authorize?client_id=" <> @client_id
  #   <> "&response_type=code&redirect_uri=" <> @redirect_uri
  #   <> "&scope=" <> scope
  # end

  # def get_access_token(code) do
  #   start()
  #   client_secret = "370d52e2a08d48b3bb7722b70469bdbc"


  #   post!("https://accounts.spotify.com/api/token",
  #     {:form, [ { :grant_type, "authorization_code"}, {:code, code}, {:redirect_uri , @redirect_uri}]},
  #     ["Authorization":  "Basic " <> Base.encode64(@client_id <> ":" <> client_secret ), "Content-Type": "application/x-www-form-urlencoded"], [])
  #   end



end
