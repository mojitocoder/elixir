defmodule Say do
  def in_english(n) when n < 0, do: {:error, "number is out of range"}
  def in_english(n) when n > 999_999_999_999, do: {:error, "number is out of range"}

  def in_english(0), do: {:ok, "zero"}
  def in_english(1), do: {:ok, "one"}

end
