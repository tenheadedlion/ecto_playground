defmodule Multi.XY do
  @repo EctoPlayground.Repo
  import Ecto.Query

  # This
  def insert_or_update_x_with_ys(x, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:ys, fn _repo, changes ->
      insert_ys(changes, params)
    end)
    |> Ecto.Multi.run(:x, fn _repo, changes ->
      insert_or_update_x(changes, x, params)
    end)
    |> @repo.transaction()
  end

  def insert_or_update_x(%{ys: ys}, x, params) do
    x
    |> ManyToMany.X.changeset(ys, params)
    |> @repo.insert_or_update()
  end

  def insert_ys(_changes, params) do
    case ManyToMany.Y.parse(params[:ys]) do
      [] ->
        {:ok, []}

      names ->
        maps =
          Enum.map(
            names,
            &%{
              name: &1
            }
          )

        @repo.insert_all(ManyToMany.Y, maps, on_conflict: :nothing)

        {:ok, @repo.all(from(y in ManyToMany.Y, where: y.name in ^names))}
    end
  end
end
