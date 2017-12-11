defmodule Luhn do
  def valid?(s) do
    s |> String.trim |> String.length > 1 # string greater than 1
    && !String.match?(s, ~r/[^\d\s]/iu) # contains only numbers or spaces
    && s |> String.replace(" ", "") #Luln checksum
         |> String.graphemes
         |> Enum.map(fn n -> String.to_integer(n) end)
         |> Enum.reverse
         |> Enum.with_index
         |> Enum.map(fn {n, i} ->
                       cond do
                         rem(i, 2) == 0 ->
                           n
                         n * 2 > 9 ->
                           n * 2 - 9
                         true ->
                           n * 2
                       end
                     end)
         |> Enum.sum
         |> rem(10) == 0
  end
end
