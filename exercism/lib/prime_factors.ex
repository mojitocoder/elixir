require Integer
defmodule PrimeFactors do
  defstruct [:n, :x, :y]

  def factors_for(1), do: []

  def factors_for(n) do
    PrimeFactors.new(n)
      |> collect
  end

  def collect(%PrimeFactors{} = tree) do
    if tree.x do
      collect(tree.x) ++ collect(tree.y)
    else
      [tree.n]
    end
  end

  def new(n) do
    tree = %PrimeFactors{n: n}
    case find_factors(n) do
      {:prime} ->
        tree
      {x, y} ->
        %PrimeFactors{tree | x: PrimeFactors.new(x), y: PrimeFactors.new(y)}
    end
  end

  def find_factors(2) do
    {:prime}
  end

  def find_factors(3) do
    {:prime}
  end

  def find_factors(n) when Integer.is_even(n) do
    {2, div(n, 2)}
  end

  def find_factors(n) do
    f =
      2..div(n, 2)
        |> Stream.map(fn i -> {i, rem(n, i) == 0} end)
        |> Stream.filter(&(elem(&1, 1)))
        |> Stream.take(1)
    if Enum.count(f) == 0 do
      {:prime}
    else
      {x, _} = f |> Enum.to_list |> List.first
      {x, div(n, x)}
    end
  end
end
