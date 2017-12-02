defmodule Matrix do
  def from_string(input) do
    input |> String.split("\n")
          |> Enum.map(fn r -> string_to_row(r) end)
  end

  def to_string(matrix) do
    matrix |> Enum.map(fn r -> r |> Enum.join(" ") end)
           |> Enum.join("\n")
  end

  def rows(matrix) do
    matrix
  end

  def row(matrix, index) do
    matrix |> Enum.fetch!(index)
  end

  def columns(matrix) do
    len = matrix |> Enum.fetch!(0) |> Enum.count
    0..len - 1 |> Enum.map(fn i -> column(matrix, i) end) 
  end

  def column(matrix, index) do
    matrix |> Enum.reduce([], fn (a, acc) -> acc ++ [Enum.fetch!(a, index)] end)
  end

  def string_to_row(row) do
    row |> String.split(" ")
        |> Enum.map(fn i -> i |> String.to_integer end)
  end
end
