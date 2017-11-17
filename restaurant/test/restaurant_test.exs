defmodule RestaurantTest do
  use ExUnit.Case
  doctest Restaurant

  test "greets the world" do
    assert Restaurant.hello() == :world
  end
end
