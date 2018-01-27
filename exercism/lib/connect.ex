defmodule Connect do
  def result_for(board) do
    :none
  end

  def remove_spaces(rows) do
    Enum.map(rows, &String.replace(&1, " ", ""))
  end
end
