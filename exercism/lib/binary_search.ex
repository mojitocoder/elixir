defmodule BinarySearch do
  def search({}, _), do: :not_found

  def search(t, v) do
    index =
      0..(tuple_size(t) - 1)
      |> Enum.filter(fn i -> elem(t, i) == v end)
      |> List.first()

    case index do
      nil ->
        :not_found

      _ ->
        {:ok, index}
    end
  end
end
