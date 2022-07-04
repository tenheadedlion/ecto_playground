import Config

config :ecto_playground, EctoPlayground.Repo,
  database: "db/playground.db"

config :ecto_playground, ecto_repos: [EctoPlayground.Repo]
