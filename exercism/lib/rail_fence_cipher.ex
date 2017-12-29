defmodule RailFenceCipher do
  def encode(message, k) do
    message
      |> String.graphemes
      |> Enum.with_index
      # |> Enum.group_by()

    "XXXXXXXXXOOOOOOOOO"
  end
end
