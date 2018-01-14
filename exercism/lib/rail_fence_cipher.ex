require Integer

defmodule RailFenceCipher.Coordinate do
  alias RailFenceCipher.Coordinate, as: C

  defstruct [:rail, :index]

  def new(rail, index) do
    %C{rail: rail, index: index}
  end

  def next(%C{} = previous, k) do
    cond do
      previous.index < 0 ->
        %C{rail: 0, index: 0}
      div(previous.index, k - 1) |> Integer.is_odd ->
        %C{rail: previous.rail - 1, index: previous.index + 1}
      true ->
        %C{rail: previous.rail + 1, index: previous.index + 1}
    end
  end
end

defmodule RailFenceCipher do
  alias RailFenceCipher.Coordinate, as: C

  def encode(message, 1), do: message

  def encode(message, k) do
    message
    |> String.graphemes()
    |> Enum.reduce({1..k |> Enum.map(fn _ -> [] end), C.new(0, -1)},
       fn (char, {rails, c}) ->
         c = C.next(c, k)
         rails = append(rails, c, char)
         {rails, c}
       end)
    |> elem(0) #extract the rails out from the accumulator
    |> Enum.map(&Enum.join(&1))
    |> Enum.join
  end

  def decode("", _), do: ""
  def decode(message, 1), do: message
  def decode(message, k) do
    1..String.length(message)
      |> Enum.reduce({"", C.new(0, -1), encoded_to_rails(message, k)},
         fn (_, {decoded, c, rails}) ->
           c = C.next(c, k)
           rail = rails |> Enum.at(c.rail)
           decoded = decoded <> String.slice(rail, 0, 1)
           rail = rail |> String.slice(1, String.length(rail) - 1)
           rails = rails |> List.replace_at(c.rail, rail)
           {decoded, c, rails}
         end)
      |> elem(0)
  end

  def append(rails, %C{} = c, char) do
    rail = (rails |> Enum.at(c.rail)) ++ [char]
    rails |> List.replace_at(c.rail, rail)
  end

  def rails_length(length, k) do
    1..length
      |> Enum.reduce({1..k |> Enum.map(fn _ -> 0 end), C.new(0, -1)},
         fn (_, {lengths, c}) ->
           c = C.next(c, k)
           lengths = lengths |> List.replace_at(c.rail, Enum.at(lengths, c.rail) + 1)
           {lengths, c}
         end)
      |> elem(0)
  end

  def encoded_to_rails(message, k) do
    rails_length(message |> String.length, k)
      |> Enum.reduce({[], message},
         fn (length, {rails, remaining}) ->
           rail = remaining |> String.slice(0, length)
           remaining = remaining |> String.slice(length, String.length(remaining) - length)
           {rails ++ [rail], remaining}
         end)
      |> elem(0)
  end
end
