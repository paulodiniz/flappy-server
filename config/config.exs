# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :flappy_server,
  ecto_repos: [FlappyServer.Repo]

# Configures the endpoint
config :flappy_server, FlappyServer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fzp5hER/3f1PsomdkZW+aQX1dJfh4/tY/6bZ/9rtJsqfkEmUY6ar06WAiSpiid8B",
  render_errors: [view: FlappyServer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FlappyServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
