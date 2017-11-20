defmodule CookTest do
  use ExUnit.Case


  test "inputs ingredients" do
    order = %Order{items: ["egg"]}

    assert {:ok, order} = Cook.prepare(order)

    assert %Order{} = order
    assert order.ingredients == ["egg"]

    # out = Cook.prepare(..)

  end

  test "accepts only orders" do
    assert :error == Cook.prepare(2)
  end
end
