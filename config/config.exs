import Config

config :ecto_playground, EctoPlayground.Repo,
  database: "db/playground.db",
  pool: Ecto.Adapters.SQL.Sandbox

config :ecto_playground, ecto_repos: [EctoPlayground.Repo]
