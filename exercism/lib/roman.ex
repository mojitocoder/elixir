defmodule Roman do
  def numerals(n) do
    numerals(n, [])
      |> Enum.join("")
  end

  def numerals(n, acc) do
    cond do
      (c = div(n, 1000)) > 0 ->
        numerals(rem(n, 1000), acc ++ [String.pad_leading("", c, "M")])
      n >= 900 ->
        numerals(rem(n, 900), acc ++ ["CM"])
      n >= 500 ->
        numerals(rem(n, 500), acc ++ ["D"])
      n >= 400 ->
        numerals(rem(n, 400), acc ++ ["CD"])
      (c = div(n, 100)) > 0 ->
        numerals(rem(n, 100), acc ++ [String.pad_leading("", c, "C")])
      n >= 90 ->
        numerals(rem(n, 90), acc ++ ["XC"])
      n >= 50 ->
        numerals(rem(n, 50), acc ++ ["L"])
      n >= 40 ->
        numerals(rem(n, 40), acc ++ ["XL"])
      (c = div(n, 10)) > 0 ->
        numerals(rem(n, 10), acc ++ [String.pad_leading("", c, "X")])
      n >= 9 ->
        numerals(rem(n, 9), acc ++ ["IX"])
      n >= 5 ->
        numerals(rem(n, 5), acc ++ ["V"])
      n >= 4 ->
        numerals(rem(n, 4), acc ++ ["IV"])
      (c = div(n, 1)) > 0 ->
        numerals(0, acc ++ [String.pad_leading("", c, "I")])
      true ->
        acc
    end
  end
end
