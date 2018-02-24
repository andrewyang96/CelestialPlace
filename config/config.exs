# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :celestial,
  ecto_repos: [Celestial.Repo]

# Configures the endpoint
config :celestial, CelestialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "95ATbYnc87Tw3NHXbCf7HjbzAkiQLk5Mxc/ebjSDj5wKryn651UQeMiJW7zce2oP",
  render_errors: [view: CelestialWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Celestial.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Stellar package
config :stellar,
  network: (if (Mix.env == :prod), do: :public, else: :test),
  address: "GCZLX5HCW6PDMBA7YS6HAKNO5NN5VLVLWYK4S32LWC6PMUAWPV2QSTAR"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
