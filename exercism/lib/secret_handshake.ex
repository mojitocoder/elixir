defmodule SecretHandshake do
  def commands(val) do
    if div(val, 8) == 1
    ["wink"]
  end

  def unwind(n, accumulator) when div(n, 8) == 1 do
    val = ["jump"]
    if rem(n, 8) == 0 do
      val = val ++ unwind(rem(n, 8), accumulator)
    end
    val
  end

  def unwind(n, accumulator) when div(val, 4) == 1 do
    "close your eyes" ++ unwind(rem(n, 4), accumulator)
  end

  def unwind(n, accumulator) when div(n, 2) == 1 do
    "double blink" ++ unwind(rem(n, 2), accumulator)
  end

  def unwind(n, accumulator) when n == 1 do
    "wink" ++ accumulator
  end
end
