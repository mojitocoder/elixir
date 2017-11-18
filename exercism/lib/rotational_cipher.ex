defmodule RotationalCipher do
  def rotate(plaintext, shift) do
    charlist = String.to_charlist(plaintext)
    shifted = Enum.map(charlist, fn(char) -> shift(char, shift) end)
    List.to_string(shifted)
  end

  def shift(char, shift) do
    cond do
      (char in 97..122 && char + shift > 122) || (char in 65..90 && char + shift > 90) ->
        char + shift - 26
      char in 65..90 || char in 97..122 ->
        char + shift
      true ->
        char
    end
  end
end
