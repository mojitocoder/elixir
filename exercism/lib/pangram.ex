defmodule Pangram do
  def pangram?(sentence) do
    words = sentence |> String.downcase
                     |> String.graphemes
                     |> MapSet.new

    mapset = 97..122 |> Enum.to_list
                     |> List.to_string
                     |> String.graphemes #alphabet in an array
                     |> Enum.map(fn a -> MapSet.member?(words, a) end)
                     |> MapSet.new

    MapSet.size(mapset) == 1 && MapSet.member?(mapset, true)
  end
end
