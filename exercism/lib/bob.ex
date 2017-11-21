defmodule Bob do
  def hey(q) do
    cond do
      is_silent?(q) ->
        "Fine. Be that way!"
      only_numbers?(q) ->
        "Whatever."
      is_question?(q) ->
        "Sure."
      is_shouting?(q) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  def only_numbers?(q) do
    q |> String.split(", ")
      |> Enum.map(fn w -> is_integer?(w) end)
      |> Enum.dedup
      == [true]
  end

  def is_integer?(q) do
    case Integer.parse(q) do
      { _, ""} ->
        true
      _ ->
        false
    end
  end

  def is_silent?(q) do
    String.trim(q) == ""
  end

  def is_shouting?(q) do
    String.upcase(q) == q
  end

  def is_question?(q) do
    String.last(q) == "?"
  end
end
