defmodule SumOfMultiples do
  def to(no, factor) when is_integer(factor) do
    div(factor * div(no, factor) * (div(no, factor) + 1), 2)
  end

  def to(no, factors) do


    #is_list(factors) &&
    #kn(n+1)/2
    #To find n use 1000/3 = 333 + remainder, 1000/5 = 200 + remainder, 1000/15 = 66 + remainder
    #sum multiples of 3: 3⋅333(333+1)/2=166833

    0
  end

  def find_combos([head | tail], accumulator) do

  end
end
