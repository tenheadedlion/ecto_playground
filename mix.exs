defmodule EctoPlayground.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_playground,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EctoPlayground.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ecto_sql, "~> 3.8.3"},
      {:ecto_sqlite3, "~> 0.7.5"},
      {:ecto_fields, "~>1.3.0"}
    ]
  end
end
