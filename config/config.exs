# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :music_brew_web,
  generators: [context_app: false]

# Configures the endpoint
config :music_brew_web, MusicBrewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FMkSCCBXpss+2gihSBtK8IdE++SM0da1oOb4ByvW33BzwQOm0ISdD3gJSnX5FFGP",
  render_errors: [view: MusicBrewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MusicBrewWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "bttr6JEgBjep4UiUD+HM0VH6YZ3z3v29h5j3eJC74sloP67dHSPaJqzWAHd27wR/"
  ]



# By default, the umbrella project as well as each child
# application will require this configuration file, as
# configuration and dependencies are shared in an umbrella
# project. While one could configure all applications here,
# we prefer to keep the configuration of each individual
# child application in their own app, but all other
# dependencies, regardless if they belong to one or multiple
# apps, should be configured in the umbrella to avoid confusion.
import_config "../apps/*/config/config.exs"

# Sample configuration (overrides the imported configuration above):
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
