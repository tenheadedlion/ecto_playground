defmodule MultiTest do
  use EctoPlayground.RepoCase

  @tag :multi
  test "in a transaction, one step's failure causes rollback" do
    {:error, _, _, _} = EctoPlayground.create_x_with_y_via_multi(%{x: "0mx1", y: "my1,my2"})

    ManyToMany.Y.all()
    |> IO.inspect()

    ManyToMany.Y.count()
    |> Kernel.==(0)
    |> assert
  end
end
