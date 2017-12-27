defmodule SimpleCipher do
  def encode(codepoint, key) when is_integer(codepoint) do
    cond do
      codepoint < 97 || 122 < codepoint ->
        codepoint
      codepoint + key - ?a > ?z ->
        codepoint + key - ?a - 26
      true ->
        codepoint + key - ?a
    end
  end

  def encode(message, key) do
    pair_up(message, key)
      |> Enum.map(&encode(&1.codepoint, &1.key))
      |> List.to_string
  end

  def decode(codepoint, key) when is_integer(codepoint) do
    cond do
      codepoint < 97 || 122 < codepoint ->
        codepoint
      codepoint < key ->
        codepoint - key + ?a + 26
      true ->
        codepoint - key + ?a
    end
  end

  def decode(message, key) do
    pair_up(message, key)
      |> Enum.map(&decode(&1.codepoint, &1.key))
      |> List.to_string
  end

  defp to_integer(letter) do
    letter |> String.to_charlist |> List.first
  end

  def pair_up(message, key) do
    keys = if String.length(key) < String.length(message) do
             key
               |> String.graphemes
               |> Stream.cycle
               |> Enum.take(String.length(message))
               |> List.to_string
           else
             key
           end

    0..String.length(message) - 1
      |> Enum.map(fn i ->
        %{
          codepoint: String.slice(message, i, 1) |> to_integer,
          key: String.slice(keys, i, 1) |> to_integer
        }
       end)
  end
end
