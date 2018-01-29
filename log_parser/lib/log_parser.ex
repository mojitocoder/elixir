defmodule LogParser do
  @moduledoc """
  Documentation for LogParser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LogParser.hello
      :world

  """


  def hello do
    log_file = "/usr/local/var/lib/trrmite/trrmite.event_log"
    # log_file = "/Users/quynh/projects/elixir/README.md"
    offset_file = "/usr/local/var/lib/trrmite/trrmite.offset_store"

    objects = log_file
      |> File.stream!
      |> Enum.take(5)
      |> Enum.map(fn line -> Poison.decode!(line) end)
    require IEx
    IEx.pry()
    :world
  end
end
