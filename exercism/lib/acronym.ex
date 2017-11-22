defmodule Acronym do
  def abbreviate(str) do
    str
      |> String.replace(~r/[^\w\s]/iu, " ") #remove punctuation
      |> String.split(" ", trim: true)
      |> Enum.map(fn w -> extract(w) end)
      |> Enum.join
      |> String.upcase
  end

  def extract(word) do
    word
      |> String.to_charlist
      |> Enum.with_index
      |> Enum.filter(fn {char, index} -> index == 0 || is_capital(char) end) # first or capital letters only
      |> Enum.map(fn {char, _} -> char end)
      |> List.to_string
  end

  def is_capital(char) do
    List.to_string([char]) =~ ~r/^\p{Lu}$/u
  end
end
