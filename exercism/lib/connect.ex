defmodule Connect.Hex do
  alias Connect.Hex, as: H

  defstruct [:row, :column]

  def new(row, column) do
    %H{row: row, column: column}
  end

  def get_neighbours(%H{} = hex) do
    get_lower_neighbours(hex) ++ get_nextdoor_neighbours(hex) ++ get_upper_neighbours(hex)
  end

  defp get_lower_neighbours(%H{} = hex) do
    cond do
      hex.row == 0 ->
        []

      true ->
        [%H{row: hex.row - 1, column: hex.column}, %H{row: hex.row - 1, column: hex.column + 1}]
    end
  end

  defp get_upper_neighbours(%H{} = hex) do
    cond do
      hex.column == 0 ->
        [%H{row: hex.row + 1, column: hex.column}]

      true ->
        [%H{row: hex.row + 1, column: hex.column - 1}, %H{row: hex.row + 1, column: hex.column}]
    end
  end

  defp get_nextdoor_neighbours(%H{} = hex) do
    cond do
      hex.column == 0 ->
        [%H{row: hex.row, column: hex.column + 1}]

      true ->
        [%H{row: hex.row, column: hex.column - 1}, %H{row: hex.row, column: hex.column + 1}]
    end
  end
end

defmodule Connect.Board do
  alias Connect.Board, as: B
  alias Connect.Hex, as: H

  def get_stones(board, colour) do
    board
    |> Enum.with_index()
    |> Enum.flat_map(fn {n, i} -> get_stones(n, colour, i) end)
  end

  defp get_stones(row, colour, index) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {n, _} -> n == get_mark(colour) end)
    |> Enum.map(fn {_, i} -> H.new(index, i) end)
  end

  defp get_mark(:white), do: "O"
  defp get_mark(:black), do: "X"
end

defmodule Connect do
  alias Connect.Hex, as: H

  def result_for(board) do
    :none
  end

  def remove_spaces(rows) do
    Enum.map(rows, &String.replace(&1, " ", ""))
  end
end
