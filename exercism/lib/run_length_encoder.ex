defmodule RunLengthEncoder do
  def encode(string) do
    string
     |> String.graphemes
     |> encode([])
     |> List.to_string
  end

  def encode([head | tail], accumulator) do

  end

  def encode([head | tail], []) do

  end

  def encode([], accumulator) do
    accumulator
  end
end
