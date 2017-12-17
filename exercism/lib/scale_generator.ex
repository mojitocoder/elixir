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

    scale |> Enum.at(post + delta)
  end

  def chromatic_scale(pitch) do
    generate_scale(@scale, pitch)
  end

  def flat_chromatic_scale(pitch) do
    generate_scale(@flat_scale, pitch)
  end

  def find_chromatic_scale(pitch) do
    if (String.length(pitch) == 2 && String.slice(pitch, 1, 1) == "b")
        || is_downcase(pitch)
        || pitch == "F" do
      flat_chromatic_scale(pitch)
    else
      chromatic_scale(pitch)
    end
  end

  defp generate_scale(scale, pitch) do
    post = find_position(scale, pitch)

    Enum.concat(scale, scale)
      |> Enum.slice(post, 13)
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
