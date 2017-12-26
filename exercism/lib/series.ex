defmodule Series do
  def largest_product(_, 0), do: 1

  def largest_product(input, k) do
    if k > String.length(input) || k < 0 do
      raise ArgumentError
    else
      input
        |> String.graphemes
        |> Enum.with_index
        |> Enum.filter(fn {_, i} -> i <= String.length(input) - k end)
        |> Enum.map(fn {_, i} -> String.slice(input, i, k) end)
        |> Enum.map(&calculate_product(&1))
        |> Enum.max
    end
  end

  def calculate_product(input) do
    input
      |> String.graphemes
      |> Enum.map(&String.to_integer(&1))
      |> Enum.reduce(1, fn (x, acc) -> x * acc end)
  end
end
