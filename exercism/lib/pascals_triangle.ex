defmodule PascalsTriangle do
  def rows(1), do: [[1]]

  def rows(i) do
    triangle = rows(i - 1)
    prev_row = triangle |> List.last

    triangle |> List.insert_at(i - 1, generate_row(prev_row))
  end

  defp generate_row(prev_row) do
    [1] ++
      (prev_row
       |> Enum.with_index
       |> Enum.map(fn {_, index} ->
                     Enum.at(prev_row, index) +
                     Enum.at(prev_row, index + 1, 0)
                   end))
  end
end
