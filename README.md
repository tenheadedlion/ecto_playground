# EctoPlayground

A playground to explore Ecto, using SQLite3, maybe Postgres later.

The playground is created in the following steps:

1. `mix new ecto_playground --sup`
2. Specify the dependencies in `mix.exs`
3. Generate Repo module by running `mix ecto.gen.repo -r Ecto.Playground.Repo`
4. Configure database in `config/config.exs`
5. Fix the Adapter type in `lib/ecto_playground/repo.ex`
6. Create database by running `mix ecto.create`

