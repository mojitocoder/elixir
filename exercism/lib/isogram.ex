defmodule Isogram do
  def isogram?(w) do
    w |> String.replace(~r/[\s\-]/iu, "")
      |> String.graphemes
      |> Enum.group_by(fn c -> c end)
      |> Enum.map(fn {_, v} -> Enum.count(v) end)
      |> Enum.max == 1
  end
end
