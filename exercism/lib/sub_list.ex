defmodule Sublist do
  def compare([], []) do
    :equal
  end

  def compare([], _) do
    :sublist
  end

  def compare(_, []) do
    :superlist
  end

  def compare(a, b) do
    cond do
      is_equal?(a, b) ->
        :equal
      Enum.count(a) < Enum.count(b) ->
        if is_sub?(a, b), do: :sublist, else: :unequal
      Enum.count(a) > Enum.count(b) ->
        if is_sub?(b, a), do: :superlist, else: :unequal
      Enum.count(a) == Enum.count(b) ->
        :unequal
    end
  end

  def is_sub?(a, b) do
    cond do
      Enum.count(a) > Enum.count(b) ->
        false
      is_sub?(a, b, :length_checked) ->
        true
      true ->
        is_sub?(a, tl(b))
    end
  end

  def is_sub?([a_head | a_tail], [b_head | b_tail], _) do
    a_head === b_head && is_sub?(a_tail, b_tail, :length_checked)
  end

  def is_sub?([], _, _) do
    true
  end

  def is_equal?(a, b) do
    Enum.count(a) == Enum.count(b) && is_equal?(a, b, :same_length)
  end

  def is_equal?([a_head | a_tail], [b_head | b_tail], _)  do
    a_head === b_head && is_equal?(a_tail, b_tail, :same_length)
  end

  def is_equal?([], [], _) do
    true
  end
end
