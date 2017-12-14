defmodule ListOps do
  def count(l), do: count(l, 0)
  defp count([_ | tail], count), do: count(tail, count + 1)
  defp count([], count), do: count

  def reverse(l), do: reverse(l, [])
  defp reverse([head | tail], acc), do: reverse(tail, [head] ++ acc)
  defp reverse([], acc), do: acc

  def map(l, func), do: map(l, func, [])
  defp map([head | tail], func, acc), do: map(tail, func, [func.(head)] ++ acc)
  defp map([], _, acc), do: reverse(acc)

  def filter(l, predicate), do: filter(l, predicate, [])
  defp filter([head | tail], predicate, acc) do
    if predicate.(head) do
      filter(tail, predicate, [head] ++ acc)
    else
      filter(tail, predicate, acc)
    end
  end
  defp filter([], _, acc), do: acc |> reverse

  def append(l1, l2), do: prepend(l1 |> reverse, l2) |> reverse
  defp prepend(l1, [head | tail]), do: prepend([head] ++ l1, tail)
  defp prepend(l1, []), do: l1

  def concat([]), do: []
  def concat([head | tail]), do: concat(head |> reverse, tail) |> reverse
  defp concat(acc, [head | tail]), do: prepend(acc, head) |> concat(tail)
  defp concat(acc, []), do: acc

  def reduce([head | tail], acc, func), do: reduce(tail, func.(head, acc), func)
  def reduce([], acc, _), do: acc
end
