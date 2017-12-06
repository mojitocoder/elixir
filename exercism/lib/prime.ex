defmodule Prime do
  def nth(0), do: raise ArgumentError, message: "Invalid argument n = 0"

  def nth(1), do: 2

  def nth(n) do
    nth(n, 3, [2])
      |> hd
  end

  def nth(n, max, primes) do
    cond do
      Enum.count(primes) == n ->
        primes
      is_prime?(max) ->
        nth(n, max + 1, [max] ++ primes)
      true ->
        nth(n, max + 1, primes)
    end
  end

  def is_prime?(n) do
    if n in [2, 3] do
      true
    else
      2..div(n, 2)
          |> Stream.drop_while(fn i -> rem(n, i)!=0 end)
          |> Stream.take(1)
          |> Enum.count == 0
    end
  end

  def infinite_stream(i \\ 1) do
    [i] |> Stream.cycle
  end

  def infinitely_increasing_stream(i \\ 1, step \\ 1) do
    infinite_stream(i) |> Stream.transform(0, fn n, acc -> {[n + acc], acc + step} end)
  end
end
