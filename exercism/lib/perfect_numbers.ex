defmodule PerfectNumbers do
  def classify(n) when n <= 0 do
    { :error, "Classification is only possible for natural numbers." }
  end

  def classify(1), do: { :ok, :deficient }

  def classify(n) do
    aliquot_sum =
      1..div(n, 2)
        |> Enum.filter(fn i -> is_factor?(i, n) end)
        |> Enum.uniq
        |> Enum.sum

    cond do
      aliquot_sum < n ->
        { :ok, :deficient }
      aliquot_sum > n ->
        { :ok, :abundant }
      true ->
        {:ok, :perfect}
    end
  end

  defp is_factor?(f, n), do: 0 == rem(n, f)
end
