defmodule LinkedList do
  def new, do: {}

  def length(list), do: tuple_size(list)

  def empty?(list), do: tuple_size(list) == 0

  def push(list, datum), do: Tuple.insert_at(list, 0, datum)

  def peek(list) do
    if empty?(list), do: {:error, :empty_list}, else: {:ok, elem(list, 0)}
  end

  def tail(list) do
    if empty?(list) do
      {:error, :empty_list}
    else
      {:ok, Tuple.delete_at(list, 0)}
    end
  end

  def pop(list) do
    if empty?(list) do
      {:error, :empty_list}
    else
      {:ok, elem(list, 0), Tuple.delete_at(list, 0)}
    end
  end

  def from_list(enum), do: from_list(enum, {})

  def to_list(list), do: to_list(list, [])

  def reverse(list), do: reverse(list, {})

  defp from_list([head | tail], acc) do
    from_list(tail, Tuple.insert_at(acc, tuple_size(acc), head))
  end

  defp from_list([], acc), do: acc

  defp to_list(list, acc) do
    case pop(list) do
      {:error, :empty_list} ->
        acc
      {:ok, head, tail} ->
        to_list(tail, acc ++ [head])
    end
  end

  defp reverse(list, acc) do
    case pop(list) do
      {:error, :empty_list} ->
        acc
      {:ok, head, tail} ->
        reverse(tail, Tuple.insert_at(acc, 0, head))
    end
  end
end
