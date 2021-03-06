defmodule BinarySearchTree do
  defstruct [:data, :left, :right]

  def new(n) do
    %BinarySearchTree{data: n}
  end

  def insert(%BinarySearchTree{} = tree, n) do
    cond do
      n <= tree.data && tree.left == nil ->
        %BinarySearchTree{tree | left: new(n)}
      n <= tree.data && tree.left != nil ->
        %BinarySearchTree{tree | left: insert(tree.left, n)}
      tree.data < n && tree.right == nil ->
        %BinarySearchTree{tree | right: new(n)}
      tree.data < n && tree.right != nil ->
        %BinarySearchTree{tree | right: insert(tree.right, n)}
    end
  end

  def in_order(%BinarySearchTree{} = tree) do
    left = if tree.left, do: in_order(tree.left), else: []
    right = if tree.right, do: in_order(tree.right), else: [] 
    left ++ [tree.data] ++ right
  end
end
