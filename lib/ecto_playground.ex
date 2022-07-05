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
end
