defmodule Tournament.Team do
  defstruct [name: nil, mp: 0, w: 0, d: 0, l: 0, p: 0]
end

defmodule Tournament.League do
  alias Tournament.Team, as: T

  def add_result(team_list, team_name, result) do
    team_list = Map.put_new(team_list, team_name, %T{name: team_name})
    team =  team_list[team_name]
    team = case result do
             :win ->
               %{team | mp: team.mp + 1, w: team.w + 1, p: team.p + 3}
             :draw ->
               %{team | mp: team.mp + 1, d: team.d + 1, p: team.p + 1}
             :loss ->
               %{team | mp: team.mp + 1, l: team.l + 1}
           end
    Map.put(team_list, team_name, team)
  end
end

defmodule Tournament do
  alias Tournament.League, as: L

  def tally(input) do
    input |> Enum.map(&split(&1))
          |> Enum.filter(&(!is_nil(&1)))
          |> List.flatten()
          |> Enum.reduce(%{}, fn({t, r}, acc) ->
                                L.add_result(acc, t, r)
                              end)
          |> Enum.map(fn {_, v} -> v end)
          |> Enum.sort(&(&1.p >= &2.p))
          |> print
  end

  def split(l) do
    arr = l |> String.split(";")
    if Enum.count(arr) == 3 do
      [home, away, result] = arr
      case String.to_atom(result) do
        :win ->
          [{home, :win}, {away, :loss}]
        :draw ->
          [{home, :draw}, {away, :draw}]
        :loss ->
          [{home, :loss}, {away, :win}]
        _ ->
          nil
      end
    end
  end

  defp print(teams) when is_list(teams) do
    "Team                           | MP |  W |  D |  L |  P\n" <>
    (teams |> Enum.map(fn team -> print(team) end)
           |> Enum.join("\n"))
  end

  defp print(team) do
      String.pad_trailing(team.name, 30) <> " | "
      <> String.pad_leading("#{team.mp}", 2) <> " | "
      <> String.pad_leading("#{team.w}", 2) <> " | "
      <> String.pad_leading("#{team.d}", 2) <> " | "
      <> String.pad_leading("#{team.l}", 2) <> " | "
      <> String.pad_leading("#{team.p}", 2)
  end
end
