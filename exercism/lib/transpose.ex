defmodule Transpose do
  def transpose(""), do: ""

  def transpose(input) when is_binary(input) do
    width =
      input |> String.split("\n")
            |> Enum.map(&String.length(&1))
            |> Enum.max

    input |> String.split("\n")
          |> Enum.map(fn line ->
                        line
                          |> String.pad_trailing(width)
                          |> String.graphemes
                      end)
          |> transpose
          |> Enum.with_index
          |> Enum.map(fn {arr, i} ->
                        if i + 1 == width do
                          Enum.join(arr, "")
                            |> String.trim_trailing
                        else
                          Enum.join(arr, "")
                        end
                      end)
          |> Enum.join("\n")
  end

  def transpose(matrix) when is_list(matrix) do
    0..(matrix |> List.first |> Enum.count) - 1
      |> Enum.map(&extract_column(matrix, &1))
  end

  defp extract_column(matrix, n) do
    matrix |> Enum.map(&Enum.at(&1, n))
  end
end
