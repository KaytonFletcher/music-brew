defmodule MusicBrewWeb.PageController do
  use MusicBrewWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, MusicBrewWeb.LiveDemoView, session: %{})
  end
end
