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
       fn (char, {rails, coordinate}) ->
         coordinate = C.next(coordinate, k)
         rails = append(rails, coordinate, char)
         {rails, coordinate}
       end)
    |> elem(0) #extract the rails out from the accumulator
    |> Enum.map(&Enum.join(&1))
    |> Enum.join
  end

  def append(rails, %C{} = coordinate, char) do
    rail = (rails |> Enum.at(coordinate.rail)) ++ [char]
    rails |> List.replace_at(coordinate.rail, rail)
  end
end
