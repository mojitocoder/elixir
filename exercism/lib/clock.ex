defmodule Clock do
  defstruct [:hour, :minute]

  def new(h, m) do
    {min, spare_hours} = rollover_minute(m)
    hour = rollover_hour(h + spare_hours)

    %Clock{
      hour: hour,
      minute: min
    }
  end

  defp rollover_hour(h) do
    cond do
      h < 0 ->
        abs(round(Float.floor(h / 24))) * 24 + h

      true ->
        rem(h, 24)
    end
  end

  defp rollover_minute(m) do
    cond do
      m < 0 ->
        {abs(round(Float.floor(m / 60))) * 60 + m, round(Float.floor(m / 60))}

      true ->
        {rem(m, 60), div(m, 60)}
    end
  end
end

defimpl String.Chars, for: Clock do
  def to_string(clock) do
    h = String.pad_leading("#{clock.hour}", 2, "0")
    m = String.pad_leading("#{clock.minute}", 2, "0")
    "#{h}:#{m}"
  end
end
