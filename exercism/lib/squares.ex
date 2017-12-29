defmodule Squares do
  def square_of_sums(n) do
    1..n
      |> Enum.sum
      |> :math.pow(2)
      |> round
  end

  def sum_of_squares(n) do
    1..n
      |> Enum.map(&(&1 * &1))
      |> Enum.sum
  end

  def difference(n) do
    square_of_sums(n) - sum_of_squares(n)
  end
end
