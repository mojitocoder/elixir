defmodule SaddlePoints do
  def rows(rows) do
    rows |> String.split("\n")
         |> Enum.map(&string_to_row(&1))
  end

  def columns(columns) do
    columns |> rows |> transpose
  end

  def saddle_points(rows) do
    matrix = rows(rows)
    0..(matrix |> Enum.count) - 1
      |> Enum.map(fn i ->
                    0..(matrix |> Enum.at(i) |> Enum.count) - 1
                      |> Enum.map(fn j ->
                                    {i, j}
                                  end)
                  end)
      |> List.flatten
      |> Enum.filter(fn {x, y} -> is_saddle_point?({x, y}, matrix) end)
  end

  defp is_saddle_point?({x, y}, matrix) do
    row = matrix |> Enum.at(x)
    column = matrix |> transpose |> Enum.at(y)
    val = row |> Enum.at(y)
    is_largest?(val, row) && is_smallest?(val, column)
  end

  defp is_largest?(val, arr), do: val >= Enum.max(arr)

  defp is_smallest?(val, arr), do: val <= Enum.min(arr)

  defp string_to_row(row) do
    row |> String.split(" ")
        |> Enum.map(&String.to_integer(&1))
  end

  defp transpose(matrix) do
    0..(matrix |> List.first |> Enum.count) - 1
      |> Enum.map(&extract_column(matrix, &1))
  end

  defp extract_column(matrix, n) do
    matrix |> Enum.map(&Enum.at(&1, n))
  end
end
