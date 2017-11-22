defmodule Accumulate do
  def accumulate([head | tail], func) do
    [func.(head)] ++ accumulate(tail, func)
  end

  def accumulate([], _) do
    []
  end
end
