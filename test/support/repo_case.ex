defmodule EctoPlayground.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias EctoPlayground.Repo

      import Ecto
      import Ecto.Query
      import EctoPlayground.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EctoPlayground.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(EctoPlayground.Repo, {:shared, self()})
    end

    :ok
  end
end
