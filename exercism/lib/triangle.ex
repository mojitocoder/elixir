defmodule Triangle do
  def kind(a, b, c) do
    cond do
      [a,b,c] |> Enum.min < 0 ->
        { :error, "all side lengths must be positive" }
      [a,b,c] |> Enum.uniq |> Enum.count == 1 && a == 0 ->
        { :error, "all side lengths must be positive" }
      a + b <= c || a + c <= b || b + c <= a ->
        { :error, "side lengths violate triangle inequality" }
      [a,b,c] |> Enum.uniq |> Enum.count == 1 ->
        { :ok, :equilateral }
      [a,b,c] |> Enum.uniq |> Enum.count == 2 ->
        { :ok, :isosceles }
      true ->
        { :ok, :scalene }
    end
  end
end
