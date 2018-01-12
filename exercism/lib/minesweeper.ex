defmodule Minesweeper.Coordinate do
  alias Minesweeper.Coordinate, as: C

  defstruct [:row, :column]

  def new(row, column) do
    %C{row: row, column: column}
  end

  def columns(b) do
    b
    |> List.first()
    |> String.graphemes()
    |> Enum.count()
  end

  def rows(b) do
    b |> Enum.count()
  end
end

defmodule Minesweeper do
  alias Minesweeper.Coordinate, as: C

  def annotate([]), do: []

  def annotate(b) do
    get_all_coordinates(b)
    |> Enum.reduce(b, fn c, acc -> annotate(acc, c) end)
  end

  def annotate(b, %C{} = me) do
    if value_of(me, b) == " " do
      row =
        b
        |> Enum.at(me.row)
        |> String.graphemes()
        |> List.replace_at(me.column, count_mines_for(me, b))
        |> Enum.join()

      b |> List.replace_at(me.row, row)
    else
      b
    end
  end

  def get_all_coordinates(b) do
    for r <- 0..(C.rows(b) - 1),
        c <- 0..(C.columns(b) - 1),
        do: C.new(r, c)
  end

  def count_mines_for(%C{} = me, b) do
    mines =
      neighbours_of(me, b)
      |> Enum.filter(fn c -> value_of(c, b) == "*" end)
      |> Enum.count()

    if mines > 0, do: "#{mines}", else: " "
  end

  def neighbours_of(%C{} = me, b) do
    [
      %C{row: me.row, column: me.column - 1},
      %C{row: me.row - 1, column: me.column - 1},
      %C{row: me.row - 1, column: me.column},
      %C{row: me.row - 1, column: me.column + 1},
      %C{row: me.row, column: me.column + 1},
      %C{row: me.row + 1, column: me.column + 1},
      %C{row: me.row + 1, column: me.column},
      %C{row: me.row + 1, column: me.column - 1}
    ]
    |> Enum.filter(fn c ->
      0 <= c.row && c.row < C.rows(b) && 0 <= c.column && c.column <= C.columns(b)
    end)
  end

  def value_of(%C{} = me, b) do
    b
    |> Enum.at(me.row)
    |> String.graphemes()
    |> Enum.at(me.column)
  end

  def clean(b), do: Enum.map(b, &String.replace(&1, ~r/[^*]/, " "))
end