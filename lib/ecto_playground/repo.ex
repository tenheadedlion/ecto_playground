defmodule EctoPlayground.Repo do
  use Ecto.Repo,
    otp_app: :ecto_playground,
    adapter: Ecto.Adapters.SQLite3
end
