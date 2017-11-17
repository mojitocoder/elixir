defmodule NucleotideCount do
  # def count(dna, symbol) do
  #   chars = String.graphemes(dna)
  #   char = List.to_string([symbol])
  #   Enum.count(chars, fn(ch) -> ch == char end)
  #   Enum.count(String.graphemes(dna), fn(char) -> char == List.to_string([symbol]) end)
  # end

  def count(dna, symbol) do
    Enum.count(dna, fn(char) -> char == symbol end)
  end

  def histogram(dna) do
    %{
      ?A => count(dna, ?A),
      ?T => count(dna, ?T),
      ?C => count(dna, ?C),
      ?G => count(dna, ?G)
    }
  end
end
