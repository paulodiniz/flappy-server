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


config :flappy_server, :adjectives, ~w(
  Autumn Hidden Bitter Misty Silent Empty Dry Dark Summer
  Icy Delicate Quiet White Cool Spring Winter Patient
  Twilight Dawn Crimson Wispy Weathered Blue Billowing
  Broken Cold Damp Falling Frosty Green Long Late Lingering
  Bold Little Morning Muddy Old Red Rough Still Small
  Sparkling Throbbing Shy Wandering Withered Wild Black
  Young Holy Solitary Fragrant Aged Snowy Proud Floral
  Restless Divine Polished Ancient Purple Lively Nameless
)

config :flappy_server, :nouns, ~w(
  Waterfall River Breeze Moon Rain Wind Sea Morning
  Snow Lake Sunset Pine Shadow Leaf Dawn Glitter Forest
  Hill Cloud Meadow Sun Glade Bird Brook Butterfly
  Bush Dew Dust Field Fire Flower Firefly Feather Grass
  Haze Mountain Night Pond Darkness Snowflake Silence
  Sound Sky Shape Surf Thunder Violet Water Wildflower
  Wave Water Resonance Sun Wood Dream Cherry Tree Fog
  Frost Voice Paper Frog Smoke Star
)
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
