defmodule Dominoes.Line do
  alias Dominoes.Line, as: L

  defstruct [:length, :head, :tail]

  def new, do: %L{length: 0}

  defp append_to_one(%L{} = line, domino) do
    cond do
      line.tail == elem(domino, 0) ->
        {:ok, %L{length: 2, head: line.head, tail: elem(domino, 1)}}

      line.tail == elem(domino, 1) ->
        {:ok, %L{length: 2, head: line.head, tail: elem(domino, 0)}}

      line.head == elem(domino, 0) ->
        {:ok, %L{length: 2, head: line.tail, tail: elem(domino, 1)}}

      line.head == elem(domino, 1) ->
        {:ok, %L{length: 2, head: line.tail, tail: elem(domino, 0)}}

      true ->
        {:error}
    end
  end

  defp append_to_many(%L{} = line, domino) do
    cond do
      line.tail == elem(domino, 0) ->
        {:ok, %L{length: line.length + 1, head: line.head, tail: elem(domino, 1)}}

      line.tail == elem(domino, 1) ->
        {:ok, %L{length: line.length + 1, head: line.head, tail: elem(domino, 0)}}

      true ->
        {:error}
    end
  end

  def append(%L{} = line, domino) do
    cond do
      line.length == 0 ->
        {:ok, %L{length: 1, head: elem(domino, 0), tail: elem(domino, 1)}}

      length(line) == 1 ->
        append_to_one(line, domino)

      true ->
        append_to_many(line, domino)
    end
  end
end

defmodule Dominoes do
  alias Dominoes.Line, as: L

  def chain?([]), do: true

  def chain?(dominoes) do
    false
  end

  def line?(sequence) do
    true
    # sequence
    # |> Enum.reduce
  end
end
