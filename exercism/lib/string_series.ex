defmodule StringSeries do
  def slices(string, len) do
    if len <= 0 do
      []
    else
      string
        |> String.to_charlist
        |> Enum.with_index
        |> Enum.filter(fn {_, index} -> index <= String.length(string) - len end)
        |> Enum.map(fn {_, index} -> String.slice(string, index, len) end)
    end
  end
end
