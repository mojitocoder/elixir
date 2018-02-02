defmodule Clock do
  defstruct [:hour, :minute]

  def new(h, m) do
    %Clock{
      hour: rem(div(m, 60) + h, 24),
      minute: rem(m, 60)
    }
  end
end

defimpl String.Chars, for: Clock do
  def to_string(clock) do
    h = String.pad_leading("#{clock.hour}", 2, "0")
    m = String.pad_leading("#{clock.minute}", 2, "0")
    "#{h}:#{m}"
  end
end
