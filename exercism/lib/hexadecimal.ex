defmodule Hexadecimal do
  def to_decimal(input) do
    try do
      input
        |> String.downcase
        |> String.graphemes
        |> Enum.map(&to_num(&1))
        |> Enum.reverse
        |> Enum.with_index
        |> Enum.map(fn {x, i} -> x * round(:math.pow(16, i)) end)
        |> Enum.sum
    rescue
      _ in ArgumentError -> 0
    end
  end

  def to_num(i) do
    case i do
      "a" -> 10
      "b" -> 11
      "c" -> 12
      "d" -> 13
      "e" -> 14
      "f" -> 15
      _   -> String.to_integer(i)
    end
  end
end
