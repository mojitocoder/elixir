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
    IO.puts "compare"
    if is_equal?(a, b) do
      :equal
    else
      cond do
        Enum.count(a) < Enum.count(b) ->
          if is_sub?(a, b), do: :sublist, else: :unequal
        Enum.count(a) > Enum.count(b) ->
          if is_sub?(b, a), do: :superlist, else: :unequal
        Enum.count(a) == Enum.count(b) ->
          :unequal
      end
    end
  end

  def is_sub?(a, b) do
    if Enum.count(a) > Enum.count(b) do
      false
    else
      if is_sub?(a, b, :length_checked) do
        true
      else
        is_sub?(a, tl(b))
      end
    end
  end

  def is_sub?([a_head | a_tail], [b_head | b_tail], _) do
    if a_head === b_head do
      is_sub?(a_tail, b_tail, :length_checked)
    else
      false
    end
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
