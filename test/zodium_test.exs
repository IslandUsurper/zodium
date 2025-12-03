defmodule ZodiumTest do
  use ExUnit.Case
  doctest Zodium

  test "greets the world" do
    assert Zodium.hello() == :world
  end
end
