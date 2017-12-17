defmodule Garden do
  @plants %{"V" => :violets,
            "R" => :radishes,
            "C" => :clover,
            "G" => :grass}

  @names [:alice, :bob, :charlie, :david,
          :eve, :fred, :ginny, :harriet,
          :ileana, :joseph, :kincaid, :larry]

  def info(str), do: info(str, @names)

  def info(str, children) do
    children |> Enum.sort
             |> Enum.with_index
             |> Map.new(fn {child, index} ->
                          {child, get_plants(str, index)}
                        end)
  end

  def get_plants(str, post) do
    if div(String.length(str) - 1, 2) >= (post + 1) * 2 do
      [r1, r2] = str |> String.split("\n")
      {@plants[String.slice(r1, post * 2, 1)],
       @plants[String.slice(r1, post * 2 + 1, 1)],
       @plants[String.slice(r2, post * 2, 1)],
       @plants[String.slice(r2, post * 2 + 1, 1)]}
    else
      {}
    end
  end
end
