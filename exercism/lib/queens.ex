defmodule Queens do
  def new do
    new({0, 3}, {7, 3})
  end

  def new(white_post, black_post) do
    if white_post == black_post do
      raise ArgumentError, message: "Two queens cannot occupy the same space"
    else
      %{white: white_post, black: black_post}
    end
  end

  def to_string(queens) do
    0..7
      |> Enum.map(fn _ -> ["_", "_", "_", "_", "_", "_", "_", "_"] end)
      |> place_queen(queens.white, "W")
      |> place_queen(queens.black, "B")
      |> Enum.map(fn row -> Enum.join(row, " ") end)
      |> Enum.join("\n")
  end

  def can_attack?(queens) do
    {x_w, y_w} = queens.white
    {x_b, y_b} = queens.black
    (x_w == x_b) || (y_w == y_b) || (abs(x_w - x_b) == abs(y_w - y_b))
  end

  defp place_queen(board, post, queen) do
    {x, y} = post
    row = board
            |> Enum.at(x)
            |> List.replace_at(y, queen)
    board |> List.replace_at(x, row)
  end
end
