defmodule BeerSong do
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(n) do
    """
    #{bottles(n)} of beer on the wall, #{bottles(n)} of beer.
    Take #{if n>1, do: "one", else: "it"} down and pass it around, #{bottles(n-1)} of beer on the wall.
    """
  end

  def lyrics(range) do
    range |> Enum.map(fn i -> verse(i) end)
          |> Enum.join("\n")
  end

  def lyrics do
    lyrics(99..0)
  end

  defp bottles(0), do: "no more bottles"

  defp bottles(1), do: "1 bottle"

  defp bottles(n), do: "#{n} bottles"
end
