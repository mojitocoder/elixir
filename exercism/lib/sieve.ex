defmodule Sieve do
  def primes_to(n) do
    2..n
      |> Enum.reduce({Enum.to_list(2..n), []}, &reduce(&1, &2))
      |> elem(1)
      |> Enum.reverse
  end

  def reduce(i, {candidates, primes}) do
    if i in candidates do
      {candidates |> Enum.filter(&(rem(&1, i) != 0)), [i] ++ primes}
    else
      {candidates, primes}
    end
  end
end
