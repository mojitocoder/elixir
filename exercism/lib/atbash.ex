defmodule Atbash do
  def encode(input) do
    input
      |> String.downcase
      |> String.replace(" ", "")
      |> String.replace(",", "")
      |> String.replace(".", "")
      |> String.graphemes
      |> Enum.map(&map_letter(&1))
      |> Enum.with_index
      |> Enum.group_by(fn {_, i} -> div(i, 5) end, &elem(&1, 0))
      |> Enum.map(fn {_, v} -> List.to_string(v) end)
      |> Enum.join(" ")
  end

  def decode(input) do
    input
      |> String.replace(" ", "")
      |> String.graphemes
      |> Enum.map(&map_letter(&1))
      |> List.to_string
  end

  def map_letter(l) do
    codepoint =
      l |> String.to_charlist
        |> List.first

    if codepoint in 97..122 do
      219 - codepoint
    else
      codepoint
    end
  end
end
