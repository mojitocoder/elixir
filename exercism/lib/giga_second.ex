defmodule Gigasecond do
  def from(erl_tuple) do
    erl_tuple |> NaiveDateTime.from_erl
              |> elem(1)
              |> NaiveDateTime.add(:math.pow(10,9) |> round)
              |> NaiveDateTime.to_erl()
  end

  # def from({{year, month, day}, {hour, minute, second}}) do
  #   {:ok, from} = NaiveDateTime.new(year, month, day, hour, minute, second)
  #
  #   from |> NaiveDateTime.add(:math.pow(10,9) |> round)
  #        |> NaiveDateTime.to_erl()
  # end
end
