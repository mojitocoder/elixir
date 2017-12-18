defmodule Meetup do
  def meetup(year, month, day, order) do
    {:ok, first_day} = {year, month, 1} |> Date.from_erl
    days_in_month = first_day |> Date.days_in_month
    day_of_week = day_to_num(day)

    candidates = 1..days_in_month
      |> Enum.map(fn d -> first_day |> Date.add(d - 1) end)
      |> Enum.filter(fn d -> Date.day_of_week(d) == day_of_week end)

    case order do
      :teenth ->
        candidates
          |> Enum.filter(fn d -> 13 <= d.day && d.day <= 19 end)
          |> List.first
          |> Date.to_erl
      :first ->
        candidates
          |> List.first
          |> Date.to_erl
      :second ->
        candidates
          |> Enum.at(1)
          |> Date.to_erl
      :third ->
        candidates
          |> Enum.at(2)
          |> Date.to_erl
      :fourth ->
        candidates
          |> Enum.at(3)
          |> Date.to_erl
      :last ->
        candidates
          |> List.last
          |> Date.to_erl
    end
  end

  def day_to_num(day) do
    case day do
      :monday     -> 1
      :tuesday    -> 2
      :wednesday  -> 3
      :thursday   -> 4
      :friday     -> 5
      :saturday   -> 6
      :sunday     -> 7
    end
  end
end
