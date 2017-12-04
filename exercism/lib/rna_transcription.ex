defmodule RNATranscription do
  # def to_rna(dna) do
  #   Enum.map dna, &transcribe(&1)
  # end
  #
  # defp transcribe(?C), do: ?G
  # defp transcribe(?G), do: ?C
  # defp transcribe(?A), do: ?U
  # defp transcribe(?T), do: ?A

  def to_rna(?G) do
    ?C
  end

  def to_rna(?C) do
    ?G
  end

  def to_rna(?T) do
    ?A
  end

  def to_rna(?A) do
    ?U
  end

  def to_rna(char_list) do
    char_list |> Enum.map(fn c -> to_rna(c) end)
  end
end
