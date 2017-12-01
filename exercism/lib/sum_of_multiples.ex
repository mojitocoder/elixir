defmodule SumOfMultiples do
  def multiples([head | tail], number, accumulator) do
    if rem(head, number) == 0 do
      multiples(tail, number, accumulator ++ [head])
    else
      multiples(tail, number, accumulator)
    end
  end

  def multiples([], _, accumulator) do
    accumulator
  end

  def to(limit, numbers) do
    numbers |> Enum.map(fn n -> multiples(1..limit-1 |> Enum.to_list, n, []) end)
            |> List.flatten
            |> MapSet.new
            |> Enum.sum
  end
end

defmodule SumOfMultiples_ do
  def to(no, factor) when is_integer(factor) do
    div(factor * div(no - 1, factor) * (div(no - 1, factor) + 1), 2)
  end

  def to(no, factors) do
    #kn(n+1)/2
    #To find n use 1000/3 = 333 + remainder, 1000/5 = 200 + remainder, 1000/15 = 66 + remainder
    #sum multiples of 3: 3⋅333(333+1)/2=166833

    add = factors |> Enum.map(fn f -> to(no, f) end)
                  |> Enum.sum

    minus = factors |> multiples([])
                    |> Enum.map(fn f -> to(no, f) end)
                    |> Enum.sum
    add - minus
  end

  def multiples([_ | []], accumulator) do
    accumulator
  end

  def multiples([head | tail], accumulator) do
    multiples(tail, accumulator ++ [lcm(head, hd(tail))])
  end

  def lcm(a, b) do
    div(a * b, gcd(a, b))
  end

  def gcd(a, b) when a == b do
    a
  end

  def gcd(a, b) when a > b do
    gcd(a - b, b)
  end

  def gcd(a, b) when a < b do
    gcd(a, b - a)
  end
end
