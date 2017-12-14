defmodule Team do
  defstruct [name: nil, mp: 0, w: 0, d: 0, l: 0, p: 0]
end

defmodule Tournament do
  def tally(input) do

  end

  def print(teams) when is_list(teams) do
    teams |> Enum.sort
          |> Enum.map(fn team -> print(team) end)
          |> Enum.join("\n")
  end

  def print(team) do
    String.pad_trailing(team.name, 30) <> " | "
      <> String.pad_leading(team.mp, 2) <> " | "
      <> String.pad_leading(team.w, 2) <> " | "
      <> String.pad_leading(team.d, 2) <> " | "
      <> String.pad_leading(team.l, 2) <> " | "
      <> String.pad_leading(team.p, 2)
  end
end
