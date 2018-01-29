defmodule LogParserTest do
  use ExUnit.Case
  doctest LogParser

  test "greets the world" do
    assert LogParser.hello() == :world
  end
end
