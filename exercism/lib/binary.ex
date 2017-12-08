defmodule Binary do
  def to_decimal(b) do
    cond do
      b <> "01"
        |> String.graphemes
        |> Enum.uniq
        |> Enum.sort != ["0", "1"] ->
        0
      true ->
        b |> String.graphemes
          |> Enum.reverse
          |> Enum.with_index
          |> Enum.map(fn {n, i} -> String.to_integer(n) * (:math.pow(2, i) |> round) end)
          |> Enum.sum
    end
  end
end
