defmodule Change do
  def generate(coins, v) do
    change = coins
              |> Enum.reverse
              |> Enum.reduce({v, []},
                  fn (x, acc) ->
                    if elem(acc, 0) >= x do
                      repeat = div(elem(acc, 0), x)
                      {rem(elem(acc, 0), x), ([x] |> Stream.cycle |> Enum.take(repeat)) ++ elem(acc, 1)}
                    else
                      acc
                    end
                  end)
    {:ok, elem(change, 1)}
  end
end
