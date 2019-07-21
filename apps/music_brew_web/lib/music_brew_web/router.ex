defmodule MusicBrewWeb.Router do
  use MusicBrewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MusicBrewWeb.Authenticator
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MusicBrewWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/spotify/login", SpotifyController, :auth
    get "/callback", SpotifyController, :getAccessToken
    get "/spotify/landing", SpotifyController, :new
    get "/parties/:id", PartyController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MusicBrewWeb do
  #   pipe_through :api
  # end
end
