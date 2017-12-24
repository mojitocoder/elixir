require Integer

defmodule PrimeFactors2 do
  defstruct [:n, :p, :x]

  def factors_for(1), do: []

  def factors_for(n) do
    PrimeFactors2.new(n)
      |> PrimeFactors2.collect
  end

  def new(n) do
    tree = %PrimeFactors2{n: n}
    if (p = find_first_prime_factor(n)) == n do
      tree
    else
      %PrimeFactors2{tree | p: p, x: PrimeFactors2.new(div(n, p))}
    end
  end

  def collect(%PrimeFactors2{} = tree) do
    if tree.p do
      [tree.p] ++ collect(tree.x)
    else
      [tree.n]
    end
  end

  def find_first_prime_factor(n) do
    2..n
      |> Enum.reduce_while(Enum.to_list(2..n), &reduce(&1, &2, n))
  end

  defp reduce(i, candidates, n) do
    cond do
      rem(n, i) == 0 ->
        {:halt, i}
      i in candidates ->
        {:cont, Enum.filter(candidates, &(rem(&1, i) != 0))}
      true ->
        {:cont, candidates}
    end
  end
end

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
        |> Enum.to_list

    if Enum.count(f) == 0 do
      {:prime}
    else
      {x, _} = f |> Enum.to_list |> List.first
      {x, div(n, x)}
    end
  end
end
