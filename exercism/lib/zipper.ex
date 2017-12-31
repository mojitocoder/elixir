defmodule BinTree do
  defstruct [:value, :left, :right]
end

defmodule ZipperHelper do
  alias BinTree, as: BT

  def bt(value, left, right), do: %BT{value: value, left: left, right: right}
  def leaf(value), do: %BT{value: value}

  def t1, do: bt(1, bt(2, nil,     leaf(3)), leaf(4))
  def t2, do: bt(1, bt(5, nil,     leaf(3)), leaf(4))
  def t3, do: bt(1, bt(2, leaf(5), leaf(3)), leaf(4))
  def t4, do: bt(1, leaf(2),                 leaf(4))
  def t5, do: bt(1, bt(2, nil, leaf(3)),
                     bt(6, leaf(7), leaf(8)))
  def t6, do: bt(1, bt(2, nil,     leaf(5)), leaf(4))
end

defmodule Zipper do
  defstruct [:data, :focus]

  def from_tree(%BinTree{} = tree) do
    data = add_node_to_map(%{}, "", tree)
    %Zipper{data: data, focus: ""}
  end

  def to_tree(%Zipper{} = zipper) do
    zipper.data
      |> Enum.sort(fn (a, b) ->
          String.length(elem(a,0)) < String.length(elem(b,0))
         end)
      |> Enum.reduce(nil, fn ({position, value}, acc) ->
          build_tree(acc, value, position)
         end)
  end

  def left(%Zipper{} = zipper) do
    move_focus(zipper, "#{zipper.focus}L")
  end

  def right(%Zipper{} = zipper) do
    move_focus(zipper, "#{zipper.focus}R")
  end

  def value(%Zipper{} = zipper) do
    zipper.data[zipper.focus]
  end

  def up(%Zipper{} = zipper) do
    if zipper.focus == "" do
      nil
    else
      new_focus = String.slice(zipper.focus, 0, String.length(zipper.focus) - 1)
      move_focus(zipper, new_focus)
    end
  end

  def set_value(%Zipper{} = zipper, value) do
    %Zipper{zipper | data: Map.replace(zipper.data, zipper.focus, value)}
  end

  def set_left(%Zipper{} = zipper, %BinTree{} = tree) do
    add_sub_tree(zipper, tree, "#{zipper.focus}L")
  end

  def set_left(%Zipper{} = zipper, nil) do
    remove_sub_tree(zipper, "#{zipper.focus}L")
  end

  def set_right(%Zipper{} = zipper, %BinTree{} = tree) do
    add_sub_tree(zipper, tree, "#{zipper.focus}R")
  end

  def set_right(%Zipper{} = zipper, nil) do
    remove_sub_tree(zipper, "#{zipper.focus}R")
  end

  defp move_focus(%Zipper{} = zipper, new_focus) do
    if zipper.data[new_focus] do
      %Zipper{zipper | focus: new_focus}
    else
      nil
    end
  end

  defp add_sub_tree(%Zipper{} = zipper, %BinTree{} = tree, prefix) do
    additional_map = (tree |> from_tree).data
                      |> Enum.map(fn {k, v}-> {"#{prefix}#{k}", v} end)
                      |> Map.new
    %Zipper{zipper | data: Map.merge(zipper.data, additional_map)}
  end

  defp remove_sub_tree(%Zipper{} = zipper, prefix) do
    new_map = zipper.data
                |> Enum.filter(fn {k, _} -> !String.starts_with?(k, prefix) end)
                |> Map.new
    %Zipper{zipper | data: new_map}
  end

  defp build_tree(tree, n, position) do
    cond do
      position == "" ->
        %BinTree{value: n}
      position == "L" ->
        %BinTree{tree | left: build_tree(nil, n, "")}
      position == "R" ->
        %BinTree{tree | right: build_tree(nil, n, "")}
      String.slice(position, 0, 1) == "L" ->
        %BinTree{tree | left: build_tree(tree.left, n, String.slice(position, 1, String.length(position) - 1))}
      String.slice(position, 0, 1) == "R" ->
        %BinTree{tree | right: build_tree(tree.right, n, String.slice(position, 1, String.length(position) - 1))}
    end
  end

  defp add_node_to_map(map, key, %BinTree{} = node) do
    map = Map.put(map, key, node.value)
    map = if node.left do
            add_node_to_map(map, "#{key}L", node.left)
          else
            map
          end
    if node.right do
      add_node_to_map(map, "#{key}R", node.right)
    else
      map
    end
  end
end
