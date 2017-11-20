defmodule SecretHandshake do
  def commands(n) when div(n, 16) >= 1 do
    Enum.reverse(commands(rem(n, 16)))
  end

  def commands(n) when div(n, 8) == 1 do
    if rem(n, 8) == 0 do
      ["jump"]
    else
      commands(rem(n, 8)) ++ ["jump"]
    end
  end

  def commands(n) when div(n, 4) == 1 do
    if rem(n, 4) == 0 do
      ["close your eyes"]
    else
      commands(rem(n, 4)) ++ ["close your eyes"]
    end
  end

  def commands(n) when div(n, 2) == 1 do
    if rem(n, 2) == 0 do
      ["double blink"]
    else
      commands(rem(n, 2)) ++ ["double blink"]
    end
  end

  def commands(n) when n == 1 do
    ["wink"]
  end

  def commands(n) when n == 0 do
    []
  end
end
