defmodule EctoPlaygroundTest do
  use ExUnit.Case
  doctest EctoPlayground

  test "greets the world" do
    assert EctoPlayground.hello() == :world
  end
end
