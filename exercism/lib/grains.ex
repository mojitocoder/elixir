defmodule Grains do
  def square(i) do
    if 1 <= i && i <= 64 do
      {:ok, :math.pow(2, i - 1) |> round}
    else
      { :error, "The requested square must be between 1 and 64 (inclusive)" }
    end
  end

  def total do
    {:ok, 1..64 |> Enum.map(fn i -> square(i) |> elem(1) end) |> Enum.sum}
  end
end
