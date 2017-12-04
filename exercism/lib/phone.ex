defmodule Phone do
  def number(no) do
    cleaned = no |> clean
    cond do
      String.length(cleaned) == 11
      && String.at(cleaned, 0) == "1" ->
        cleaned |> String.slice(1, 10)
      String.length(cleaned) == 11
      && String.at(cleaned, 0) != "1" ->
        "0000000000"
      String.length(cleaned) < 10
      || String.length(cleaned) > 11 ->
        "0000000000"
      String.match?(cleaned, ~r/[\D]/) -> # contains word(s)
        "0000000000"
      String.length(cleaned) == 10
      && String.slice(cleaned, 0, 1) in ["1", "0"] ->
        "0000000000"
      String.length(cleaned) == 10
      && String.slice(cleaned, 3, 1) in ["1", "0"] ->
        "0000000000"
      true ->
        cleaned
    end
  end

  def area_code(no) do
    no |> number |> String.slice(0, 3)
  end

  def pretty(no) do
    valid = no |> number
    "(#{String.slice(valid, 0, 3)}) #{String.slice(valid, 3, 3)}-#{String.slice(valid, 6, 4)}"
  end

  defp clean(no) do
    # cleaned = no |> String.replace(~r/[^\w]/, "") # remove any no-numeric chars
    no |> String.replace(~r/[\W]/, "") # remove any no-numeric chars
  end
end
