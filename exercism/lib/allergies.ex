defmodule Allergies do
  def list(n) do
    8..0 |> Enum.reduce({n, []}, fn (i, {remainder, acc}) ->
        a = :math.pow(2, i) |> round
        if remainder >= a do
          {rem(remainder, a), acc ++ [a]}
        else
          {remainder, acc}
        end
      end)
      |> elem(1)
      |> Enum.filter(&(&1 <= 128))
      |> Enum.map(&map(&1))
  end

  def allergic_to?(n, item) do
    list(n)
      |> Enum.into(MapSet.new)
      |> MapSet.member?(item)
  end

  defp map(1), do: "eggs"
  defp map(2), do: "peanuts"
  defp map(4), do: "shellfish"
  defp map(8), do: "strawberries"
  defp map(16), do: "tomatoes"
  defp map(32), do: "chocolate"
  defp map(64), do: "pollen"
  defp map(128), do: "cats"
end
