defmodule Anagram do
  def match(word, candidates) do
    dict = to_dict(word)
    candidates |> Enum.map(fn w -> {w, to_dict(w)} end)
               |> Enum.filter(fn tuple -> elem(tuple, 1) == dict end)
               |> Enum.map(fn tuple -> elem(tuple, 0) end)
               |> Enum.filter(fn w -> String.downcase(w) != String.downcase(word) end)
  end

  def to_dict(word) do
    word |> String.downcase
         |> String.graphemes
         |> Enum.group_by(fn c -> c end)
         |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
         |> Map.new(fn {k, v} -> {k, v} end)
  end
end
