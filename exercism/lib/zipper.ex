defmodule BinTree do
  defstruct [:value, :left, :right]

  # def new(n) do
  #   %BinTree{value: n}
  # end
  #
  #
  # def insert(%BinTree{} = tree, n) do
  #   cond do
  #     n <= tree.value && tree.left == nil ->
  #       %BinTree{tree | left: new(n)}
  #     n <= tree.value && tree.left != nil ->
  #       %BinTree{tree | left: insert(tree.left, n)}
  #     tree.value < n && tree.right == nil ->
  #       %BinTree{tree | right: new(n)}
  #     tree.value < n && tree.right != nil ->
  #       %BinTree{tree | right: insert(tree.right, n)}
  #   end
  # end
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

  defp add_node_to_map(map, key, %BinTree{} = node) do
    map = Map.put(map, key, node.value)
    map = if node.left do
            add_node_to_map(map, "#{key}L", node.left)
          else
            map
          end
    map = if node.right do
            add_node_to_map(map, "#{key}R", node.right)
          else
            map
          end
  end

  def to_tree(%Zipper{} = zipper) do
    zipper.data
      |> Enum.sort(fn (a, b) -> String.length(elem(a,0))< String.length(elem(b,0)) end)
      |> Enum.reduce(nil, fn ({position, value}, acc) -> build_tree(acc, value, position) end)
  end

  def build_tree(tree, n, position) do
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

  def left(zipper) do

  end

  def right(zipper) do

  end

  def value(zipper) do

  end

  def up(node) do

  end

  def set_value(node, value) do

  end

  def set_left(node, tree) do

  end

  def set_right(node, tree) do

  end
end
