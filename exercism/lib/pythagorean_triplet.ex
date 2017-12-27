defmodule Triplet do
  def sum(triplet) do
    triplet |> Enum.sum
  end

  def product(triplet) do
    triplet |> Enum.reduce(1, fn(n, acc) -> n * acc end)
  end

  def pythagorean?(triplet) do
    # sorted = triplet |> Enum.sort
    # [a, b] = sorted |> Enum.take(2)
    # c = sorted |> Enum.at(2)
    [a, b, c] = triplet

    a * a + b * b == c * c
  end

  def generate(lower, upper) do
    for a <- lower..(upper - 2),
        b <- (a + 1)..(upper - 1),
        c <- (b + 1)..upper,
        a * a + b * b == c * c,
        do: [a, b, c]
  end

  def generate(lower, upper, sum) do
    for a <- lower..(upper - 2),
        b <- (a + 1)..(upper - 1),
        c <- (b + 1)..upper,
        a + b + c == sum,
        a * a + b * b == c * c,
        do: [a, b, c]
  end
end
