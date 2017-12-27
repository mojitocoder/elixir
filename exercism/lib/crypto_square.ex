defmodule CryptoSquare do
  def encode(""), do: ""

  def encode(m) do
    normalised = m |> normalise
    r = String.length(normalised) |> :math.sqrt |> trunc
    c = if r * r == String.length(normalised), do: r, else: r + 1

    normalised
      |> String.graphemes
      |> Enum.with_index
      |> Enum.group_by(fn {_, i} -> div(i, c) end, &elem(&1, 0))
      |> Enum.map(fn {_, v} -> List.to_string(v) end)
      |> Enum.join("\n")
      |> Transpose.transpose
      |> String.split("\n")
      |> Enum.map(&String.trim(&1))
      |> Enum.join(" ")
  end

  def normalise(m) do
    m |> String.replace(~r/[^\w\s]/iu, "") #remove punctuation
      |> String.replace(" ", "")
      |> String.downcase
  end
end
