defmodule Hamming do
  def hamming_distance(a, b) do
    if Enum.count(a) != Enum.count(b) do
      {:error, "Lists must be the same length"}
    else
      d = a |> Enum.with_index
            |> Enum.count(fn {char, index} ->
                            char != Enum.at(b, index)
                          end)
      {:ok, d}
    end
  end
end
