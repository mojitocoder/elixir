defmodule Words do
  def count(str) do
    str
      |> String.downcase
      |> String.replace("_", " ")
      |> String.replace(~r/[^\w\s\-]/iu, " ")
      |> String.replace(",", " ")
      |> String.split(" ", trim: true)
      |> Enum.group_by(fn word -> word end)
      |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
      |> Map.new(fn {k, v} -> {k, v} end)
  end
end
