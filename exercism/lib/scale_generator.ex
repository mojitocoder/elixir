defmodule ScaleGenerator do
  @scale ~w(A A# B C C# D D# E F F# G G#)
  @flat_scale ~w(A Bb B C Db D Eb E F Gb G Ab)

  def step(scale, pitch, interval) do
    post = find_position(scale, pitch)
    delta = case interval do
              "m" -> 1
              "M" -> 2
              "A" -> 3
            end
    scale |> Stream.cycle |> Enum.at(post + delta)
  end

  def chromatic_scale(pitch) do
    generate_scale(@scale, pitch)
  end

  def flat_chromatic_scale(pitch) do
    generate_scale(@flat_scale, pitch)
  end

  def find_chromatic_scale(pitch) do
    pitch |> find_scale |> generate_scale(pitch)
  end

  def scale(pitch, pattern) do
    scale = find_scale(pitch)
    pattern
      |> String.graphemes
      |> Enum.reduce([find_correct_pitch(scale, pitch)],
                     fn (interval, acc) ->
                       # IEx.pry()
                       acc ++ [step(scale, List.last(acc), interval)]
                     end)
  end

  defp find_scale(pitch) do
    cond do
      (String.length(pitch) == 2 && String.slice(pitch, 1, 1) == "#")
      || pitch == "a" ->
        @scale
      (String.length(pitch) == 2 && String.slice(pitch, 1, 1) == "b")
      || is_downcase(pitch)
      || pitch == "F" ->
        @flat_scale
      true ->
        @scale
    end
  end

  defp generate_scale(scale, pitch) do
    post = find_position(scale, pitch)
    scale |> Stream.cycle
          |> Enum.slice(post, 13)
  end

  defp find_correct_pitch(scale, pitch) do
    post = find_position(scale, pitch)
    scale |> Enum.at(post)
  end

  defp find_position(scale, pitch) do
    scale |> Enum.map(&(String.downcase(&1)))
          |> Enum.with_index
          |> List.keyfind(String.downcase(pitch), 0)
          |> elem(1)
  end

  defp is_downcase(str) do
    String.downcase(str) == str
  end
end
