defmodule PigLatin do
  def translate(word) do
    if String.contains?(word, " ") do
      # parts = String.split(word, " ")
      # Enum.join(Enum.map(parts, fn w -> translate(w) end), " ")
      word
        |> String.split(" ")
        |> Enum.map(fn part -> translate(part) end)
        |> Enum.join(" ")
    else
      case String.first(word) do
        initial when initial in ["a", "e", "i", "o", "u"] ->
          "#{word}ay"
        _ ->
          if String.slice(word, 0..1) in ["yt", "xr"] do
            "#{word}ay"
          else
            prefix = get_prefix(word, "")
            "#{String.slice(word, String.length(prefix)..-1)}#{prefix}ay"
          end
      end
    end
  end

  def get_prefix(word, prefix) do
    case String.first(word) do
      initial when initial in [nil, "a", "e", "i", "o"] ->
        prefix
      "u" ->
        if String.last(prefix) == "q" do
          get_prefix(String.slice(word, 1..-1), "#{prefix}#{String.first(word)}")
        else
          prefix
        end
      _ ->
       get_prefix(String.slice(word, 1..-1), "#{prefix}#{String.first(word)}")
    end
  end
end
