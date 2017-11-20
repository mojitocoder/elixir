defmodule WaiterTest do
  use ExUnit.Case


  test "places order" do
    items = ["eggs", "cheese", "bacon"]

    order = Waiter.place_order(items)

    assert %Order{} = order
    assert order.items == items
    assert order.id != nil
  end
end
