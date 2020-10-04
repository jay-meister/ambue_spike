# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ambue_spike,
  ecto_repos: [AmbueSpike.Repo]

# Configures the endpoint
config :ambue_spike, AmbueSpikeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CKBXdamc95it2VU9NLqAk7nJxrKXfRj/uYvfneEOUDeDKLTCjKefscfsYV91G6vp",
  render_errors: [view: AmbueSpikeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AmbueSpike.PubSub,
  live_view: [signing_salt: "ICcspd2p"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
