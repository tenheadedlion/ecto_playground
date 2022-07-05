defmodule EctoPlaygroundTest do
  use EctoPlayground.RepoCase

  describe "proof of `on_replace`" do
    test "create x in many_to_many association with y" do
      {:ok, _} = EctoPlayground.create_x_with_y(%{x: "x1", y: "y1,y2"})
      {:ok, _} = EctoPlayground.create_x_with_y(%{x: "x1", y: "y2,y3"})
    end
  end
end
