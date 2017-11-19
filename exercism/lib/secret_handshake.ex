defmodule SecretHandshake do
  def commands(val) do
    if div(val, 8) == 1
    ["wink"]
  end

  def unwind(val, accumulator) when div(val, 8) == 1 do
    unwind(rem(val, 8), accumulator)
    accumulator = "jump" ++ accumulator
  end

  def unwind(n, accumulator) when div(n, 2) == 1 do
    "double blink" ++ accumulator
  end

  def unwind(n, accumulator) when n == 1 do
    "wink" ++ accumulator
  end
end
