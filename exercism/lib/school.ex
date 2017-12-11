defmodule School do
  def add(db, name, grade) do
    if Map.has_key?(db, grade) do
      db |> Map.get_and_update(grade, fn v -> {v, [name] ++ v} end)
         |> elem(1)
    else
      db |> Map.put_new(grade, [name])
    end
  end

  def grade(db, g) do
    if Map.has_key?(db, g), do: db |> Map.get(g), else: []
  end

  def sort(db) do
    db |> Map.to_list
       |> Enum.map(fn {k, v} -> {k, v |> Enum.sort} end)
  end
end
