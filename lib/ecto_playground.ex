defmodule EctoPlayground.Y do
  use Ecto.Schema

  schema "ys" do
    field(:name, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:name])
  end
end

defmodule EctoPlayground.X do
  use Ecto.Schema
  import Ecto.Query

  @repo EctoPlayground.Repo

  schema "xs" do
    field(:name, :string)

    many_to_many(:ys, EctoPlayground.Y,
      join_through: "xs_ys",
      on_replace: :mark_as_invalid
    )
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.unique_constraint(:name)
    |> Ecto.Changeset.put_assoc(:ys, handle_y(params))
  end

  defp handle_y(params) do
    (params[:ys] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> insert_ys()
  end

  defp insert_ys([]) do
    []
  end

  defp insert_ys(names) do
    maps =
      Enum.map(
        names,
        &%{
          name: &1
        }
      )

    @repo.insert_all(EctoPlayground.Y, maps, on_conflict: :nothing)

    @repo.all(from(y in EctoPlayground.Y, where: y.name in ^names))
  end
end

defmodule EctoPlayground do
  @repo EctoPlayground.Repo
  def create_x_with_y(%{
        x: x,
        y: y
      }) do
    case @repo.get_by(EctoPlayground.X, name: x) do
      nil -> %EctoPlayground.X{}
      x -> x |> @repo.preload(:ys) |> IO.inspect()
    end
    |> EctoPlayground.X.changeset(%{name: x, ys: y})
    |> @repo.insert_or_update()
  end
end
