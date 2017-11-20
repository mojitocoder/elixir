defmodule Strain do
  def keep(list, predicate) do
    keep(list, predicate, [])
  end

  defp keep([head | tail], predicate, accumulator) do
    if apply(predicate, [head]) do
      keep(tail, predicate, accumulator ++ [head])
    else
      keep(tail, predicate, accumulator)
    end
  end

  defp keep([], _, accumulator) do
    accumulator
  end

  def discard(list, predicate) do
    discard(list, predicate, [])
  end

  defp discard([head | tail], predicate, accumulator) do
    if apply(predicate, [head]) do
      discard(tail, predicate, accumulator)
    else
      discard(tail, predicate, accumulator ++ [head])
    end
  end

  defp discard([], _, accumulator) do
    accumulator
  end
end
