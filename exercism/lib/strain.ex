defmodule Strain do
  def keep(list, predicate) do
    Enum.reverse(keep(list, predicate, []))
  end

  defp keep([head | tail], predicate, accumulator) do
    if apply(predicate, [head]) do
      keep(tail, predicate, [head | accumulator])
    else
      keep(tail, predicate, accumulator)
    end
  end

  defp keep([], _, accumulator) do
    accumulator
  end

  def discard(list, predicate) do
    Enum.reverse(discard(list, predicate, []))
  end

  defp discard([head | tail], predicate, accumulator) do
    if apply(predicate, [head]) do
      discard(tail, predicate, accumulator)
    else
      discard(tail, predicate, [head | accumulator])
    end
  end

  defp discard([], _, accumulator) do
    accumulator
  end
end
