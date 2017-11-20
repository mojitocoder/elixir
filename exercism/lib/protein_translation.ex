defmodule ProteinTranslation do
  def of_codon(rna) when rna == "AUG" do
    { :ok, "Methionine" }
  end

  def of_codon(rna) when rna == "UUU" do
    { :ok, "Phenylalanine" }
  end

  def of_codon(rna) when rna == "UUC" do
    { :ok, "Phenylalanine" }
  end

  def of_codon(rna) when rna == "UUA" do
    { :ok, "Leucine" }
  end

  def of_codon(rna) when rna == "UUG" do
    { :ok, "Leucine" }
  end

  def of_codon(rna) when rna == "UCU" do
    { :ok, "Serine" }
  end

  def of_codon(rna) when rna == "UCC" do
    { :ok, "Serine" }
  end

  def of_codon(rna) when rna == "UCA" do
    { :ok, "Serine" }
  end

  def of_codon(rna) when rna == "UCG" do
    { :ok, "Serine" }
  end

  def of_codon(rna) when rna == "UAU" do
    { :ok, "Tyrosine" }
  end

  def of_codon(rna) when rna == "UAC" do
    { :ok, "Tyrosine" }
  end

  def of_codon(rna) when rna == "UGU" do
    { :ok, "Cysteine" }
  end

  def of_codon(rna) when rna == "UGC" do
    { :ok, "Cysteine" }
  end

  def of_codon(rna) when rna == "UGG" do
    { :ok, "Tryptophan" }
  end

  def of_codon(rna) when rna == "UAA" do
    { :ok, "STOP" }
  end

  def of_codon(rna) when rna == "UAG" do
    { :ok, "STOP" }
  end

  def of_codon(rna) when rna == "UGA" do
    { :ok, "STOP" }
  end

  def of_codon(_) do
    { :error, "invalid codon" }
  end

  def of_rna(strand) do
    case of_rna(strand, []) do
      :error ->
        { :error, "invalid RNA" }
      accumulator ->
        { :ok, accumulator }
    end
  end

  def of_rna(strand, accumulator) do
    rna = String.slice(strand, 0..2)

    case of_codon(rna) do
      { :ok, codon } ->
        if codon == "STOP" do
          accumulator
        else
          if String.length(strand) > 3 do
            of_rna(String.slice(strand, 3..-1), accumulator ++ [codon])
          else
            accumulator ++ [codon]
          end
        end
      { :error, _ } ->
        :error
    end
  end
end
