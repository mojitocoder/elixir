defmodule RunLengthEncoder do
  def decode("") do
    ""
  end

  def decode(string) do
    string
      |> String.graphemes
      |> decode([])
      |> Enum.reverse
      |> List.to_string
  end

  def decode([head | tail], []) do
    decode(tail, [head])
  end

  def decode([head | tail], accumulator) do
    last = hd(accumulator)
    case Integer.parse(last) do
      {int, _} ->
        case Integer.parse(head) do
          {head_int, _} ->
            decode(tail, (["#{int*10 + head_int}"] ++ tl(accumulator)))
          :error ->
            decode(tail, (1..int |> Enum.map(fn _ -> head end)) ++ tl(accumulator))
        end
      :error ->
        decode(tail, [head] ++ accumulator)
    end
  end

  def decode([], accumulator) do
    accumulator
  end

  def encode("") do
    ""
  end

  def encode(string) do
    string
     |> String.graphemes
     |> encode([])
     |> Enum.reverse
     |> Enum.map(fn {char, count} -> print({char, count}) end)
     |> List.to_string
  end

  def print({char, count}) do
    if count == 1 do
      char
    else
      "#{count}#{char}"
    end
  end

  def encode([head | tail], []) do
    encode(tail, [{head, 1}])
  end

  def encode([head | tail], accumulator) do
    {char, count} = hd(accumulator)
    if head === char do
      encode(tail, [{char, count + 1}] ++ tl(accumulator))
    else
      encode(tail, [{head, 1}] ++ accumulator)
    end
  end

  def encode([], accumulator) do
    accumulator
  end
end
