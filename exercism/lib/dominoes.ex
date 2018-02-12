defmodule Dominoes.Line do
  alias Dominoes.Line, as: L

  defstruct [:length, :head, :tail]

  def new, do: %L{length: 0}

  def append(%L{} = line, domino) do
    cond do
      line.length == 0 ->
        {:cont, %L{length: 1, head: elem(domino, 0), tail: elem(domino, 1)}}

      line.length == 1 ->
        append_to_one(line, domino)

      true ->
        append_to_many(line, domino)
    end
  end

  defp append_to_one(%L{} = line, domino) do
    cond do
      line.tail == elem(domino, 0) ->
        {:cont, %L{length: 2, head: line.head, tail: elem(domino, 1)}}

      line.tail == elem(domino, 1) ->
        {:cont, %L{length: 2, head: line.head, tail: elem(domino, 0)}}

      line.head == elem(domino, 0) ->
        {:cont, %L{length: 2, head: line.tail, tail: elem(domino, 1)}}

      line.head == elem(domino, 1) ->
        {:cont, %L{length: 2, head: line.tail, tail: elem(domino, 0)}}

      true ->
        {:halt, line}
    end
  end

  defp append_to_many(%L{} = line, domino) do
    cond do
      line.tail == elem(domino, 0) ->
        {:cont, %L{length: line.length + 1, head: line.head, tail: elem(domino, 1)}}

      line.tail == elem(domino, 1) ->
        {:cont, %L{length: line.length + 1, head: line.head, tail: elem(domino, 0)}}

      true ->
        {:halt, line}
    end
  end
end

defmodule Dominoes do
  alias Dominoes.Line, as: L

  def chain?([]), do: true

  def chain?(dominoes) do
    # sequence_is_chain?(dominoes)
    dominoes
    |> permutate_array
    |> Enum.filter(fn permutation -> sequence_is_chain?(permutation) end)
    |> Enum.count > 0
  end

  def permutate_array(a) do
    length = Enum.count(a)
    permutate(length - 1)
    |> Enum.map(fn permutation ->
      permutation |> Enum.map(fn i -> a |> Enum.at(i) end)
    end)
  end

  def permutate(0), do: [[0]]
  def permutate(n) do
    permutate(n-1)
    |> Enum.map(fn x -> permutate(x, n) end)
    |> Enum.reduce([], fn x, acc -> Enum.concat(x, acc) end)
  end

  def permutate(list, val) do
    0..Enum.count(list)
    |> Enum.map(fn i ->
      list |> List.insert_at(i, val)
    end)
  end

  def sequence_is_chain?(dominoes) do
    case line?(dominoes) do
      {:ok, line} ->
        line.head == line.tail

      _ ->
        false
    end
  end

  def line?(sequence) do
    line =
      sequence
      |> Enum.reduce_while(L.new(), fn i, acc -> L.append(acc, i) end)

    if line.length == Enum.count(sequence) do
      {:ok, line}
    else
      {:error}
    end
  end
end
