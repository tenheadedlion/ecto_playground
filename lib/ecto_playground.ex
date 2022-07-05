defmodule EctoPlayground do
  @repo EctoPlayground.Repo
  def create_x_with_y(%{
        x: x,
        y: y
      }) do
    case @repo.get_by(ManyToMany.X, name: x) do
      nil -> %ManyToMany.X{}
      x -> x |> @repo.preload(:ys)
    end
    |> ManyToMany.X.changeset(%{name: x, ys: y})
    |> @repo.insert_or_update()
  end

  def create_x_with_y_via_multi(%{
        x: x,
        y: y
      }) do
    case @repo.get_by(ManyToMany.X, name: x) do
      nil -> %ManyToMany.X{}
      x -> x |> @repo.preload(:ys)
    end
    |> Multi.XY.insert_or_update_x_with_ys(%{name: x, ys: y})
  end
end
