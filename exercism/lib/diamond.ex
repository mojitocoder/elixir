defmodule Diamond do
  def build_shape(?A), do: "A\n"

  def build_shape(x) do
    d = x - ?A
    width = 2 * d + 1

    (0..width - 1
      |> Enum.map(&abs(&1 - d))
      |> Enum.map(&{List.to_string([x - &1]), &1})
      |> Enum.map(fn {l, i} ->
                    if i == d do
                      String.pad_leading("", i)
                        <> l
                        <> String.pad_leading("", i)
                    else
                      String.pad_leading("", i)
                        <> l
                        <> String.pad_leading("", width - 2 - 2 * i)
                        <> l
                        <> String.pad_leading("", i)
                    end
                  end)
      |> Enum.join("\n")) <> "\n"
  end
end
