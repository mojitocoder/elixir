defmodule Cook do
  def prepare(%Order{items: items}) when length(items) > 5 do
    :error
  end

  def prepare(%Order{} = order) do
      # Map.put(order, :ingredients, order.items)
      order = %{order | ingredients: order.items, id: 2}
      {:ok, order}
  end

  def prepare(_) do
    :error
  end
end
