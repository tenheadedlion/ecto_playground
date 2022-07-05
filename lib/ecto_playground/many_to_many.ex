defmodule ManyToMany.Y do
  use Ecto.Schema
  import Ecto.Query
  @repo EctoPlayground.Repo
  schema "ys" do
    field(:name, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:name])
  end

  def parse(tags) do
    (tags || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
  end

  def count() do
    from(y in ManyToMany.Y,
      select: count(y.id)
    )
    |> @repo.one()
  end

  def all() do
    @repo.all(ManyToMany.Y)
  end
end

defmodule ManyToMany.X do
  use Ecto.Schema
  import Ecto.Query

  @repo EctoPlayground.Repo

  schema "xs" do
    field(:name, :string)

    many_to_many(:ys, ManyToMany.Y,
      join_through: "xs_ys",
      # on_replace: :mark_as_invalid
      on_replace: :delete
    )
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.unique_constraint(:name)
    |> Ecto.Changeset.put_assoc(:ys, handle_y(params))
  end

  def changeset(struct, ys, params) do
    struct
    |> Ecto.Changeset.cast(params, [:name])
    |> Ecto.Changeset.unique_constraint(:name)
    |> Ecto.Changeset.validate_format(:name, ~r/^[^\d]/)
    |> Ecto.Changeset.put_assoc(:ys, ys)
  end

  def handle_y(params) do
    (params[:ys] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> insert_ys()
  end

  def insert_ys([]) do
    []
  end

  def insert_ys(names) do
    maps =
      Enum.map(
        names,
        &%{
          name: &1
        }
      )

    @repo.insert_all(ManyToMany.Y, maps, on_conflict: :nothing)

    @repo.all(from(y in ManyToMany.Y, where: y.name in ^names))
  end
end
