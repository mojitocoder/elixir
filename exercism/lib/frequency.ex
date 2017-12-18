defmodule Frequency do
  def frequency(texts, workers) do
    texts
      # |> Task.async_stream(fn text -> frequency(text) end)
      |> Task.async_stream(Frequency, :frequency, [], max_concurrency: workers)
      |> Enum.map(fn {:ok, ls} -> ls end)
      |> List.flatten
      |> Enum.group_by(&(elem(&1,0)), &(elem(&1,1)))
      |> Enum.map(fn {k, v} -> {k, Enum.sum(v)} end)
  end

  def frequency(text) do
    text
      |> String.downcase
      |> String.replace(~r/[^\w]/iu, "")
      |> String.replace(~r/[\d]/iu, "")
      |> String.graphemes
      |> Enum.group_by(&(&1))
      |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
  end
end
