defmodule StringSeries do
  def slices(_, len) when len <= 0 do
    []
  end

  def slices(string, len) do
    string
      |> String.to_charlist
      |> Enum.with_index
      |> Enum.filter(fn {_, index} -> index <= String.length(string) - len end)
      |> Enum.map(fn {_, index} -> String.slice(string, index, len) end)
  end
end
