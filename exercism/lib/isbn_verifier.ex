defmodule ISBNVerifier do
  def isbn?(input) do
    naked = input |> String.replace("-", "")

    String.length(naked) == 10
      && String.match?(naked, ~r/^[0-9]*X?$/)
      && check_mod(naked)
  end

  defp check_mod(naked_isbn) do
    sum =
      naked_isbn
        |> String.graphemes
        |> Enum.map(fn n ->
                      if n == "X", do: 10, else: String.to_integer(n)
                    end)
        |> Enum.with_index
        |> Enum.map(fn {n, i} ->
                      n * (10 - i)
                    end)
        |> Enum.sum
    rem(sum, 11) == 0
  end
end
