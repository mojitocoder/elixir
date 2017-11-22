defmodule Accumulate do
  def accumulate([head | tail], func) do
    [apply(func, [head])] ++ accumulate(tail, func)
  end

  def accumulate([], _) do
    []
  end
end
