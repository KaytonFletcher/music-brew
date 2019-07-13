defmodule MusicBrewWeb.Authenticator do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    access_token =
      conn
      |> get_session(:access_token)
      |> case do
        nil -> nil
        id -> id
      end
    assign(conn, :access_token, access_token)
  end
end
