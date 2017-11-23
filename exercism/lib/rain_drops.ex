defmodule Raindrops do
  def convert(n) when rem(n, 105) == 0 do
    "PlingPlangPlong"
  end

  def convert(n) when rem(n, 15) == 0 do
    "PlingPlang"
  end

  def convert(n) when rem(n, 21) == 0 do
    "PlingPlong"
  end

  def convert(n) when rem(n, 35) == 0 do
    "PlangPlong"
  end

  def convert(n) when rem(n, 3) == 0 do
    "Pling"
  end

  def convert(n) when rem(n, 5) == 0 do
    "Plang"
  end

  def convert(n) when rem(n, 7) == 0 do
    "Plong"
  end

  def convert(n) do
    "#{n}"
  end

end
