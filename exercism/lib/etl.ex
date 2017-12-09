defmodule ETL do
  def transform(old) do
    old |> Map.to_list
        |> Enum.flat_map(fn {k, v} ->
                          v |> Enum.map(fn e -> {e, k} end) 
                         end)
        |> Map.new(fn {k, v} -> {k |> String.downcase, v} end)
  end
end
