defmodule FlattenArray do
  def flatten(a) do
    flatten(a, [])
  end

  def flatten([head | tail], acc) do
    cond do
      is_list(head) ->
        flatten(tail, acc ++ flatten(head, []))
      head == nil ->
        flatten(tail, acc)
      true ->
        flatten(tail, acc ++ [head])
    end
  end

  def flatten([], acc) do
    acc
  end
end
