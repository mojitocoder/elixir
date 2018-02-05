defmodule Stack do
  defstruct [:storage]

  def new, do: %Stack{storage: []}

  def push(%Stack{} = stack, val) do
    %Stack{storage: [val] ++ stack.storage}
  end

  def pop(%Stack{} = stack) do
    case stack.storage do
      [head | tail] -> {%Stack{storage: tail}, head}
      [] -> {stack, nil}
    end
  end

  def peek(%Stack{} = stack) do
    case stack.storage do
      [head | _] -> head
      [] -> nil
    end
  end

  def print(%Stack{} = stack) do
    stack.storage
    |> Enum.reverse()
    |> Enum.join(" ")
  end
end

defmodule Forth.DivisionByZero do
  defexception message: "Divivision by zero!"
end

defmodule Forth.StackUnderflow do
  defexception message: "StackUnderflow"
end

defmodule Forth do
  defstruct [:stack, :commands]

  def new do
    %Forth{stack: Stack.new()}
  end

  def format_stack(%Forth{} = forth) do
    forth.stack |> Stack.print()
  end

  def eval(%Forth{} = forth, exp) do
    # lines = cleanse(exp) |> String.split(";", trim: true)

    new_stack =
      cleanse(exp)
      |> String.split(" ")
      |> Enum.reduce(forth.stack, fn val, stack -> process(stack, val) end)

    %Forth{stack: new_stack}
  end

  defp process(%Stack{} = stack, val) do
    cond do
      is_int(val) ->
        Stack.push(stack, to_int(val))

      val in ["+", "-", "*", "/"] ->
        do_arithmetic(stack, String.to_atom(val))

      String.upcase(val) == "DUP" ->
        do_dup(stack)

      String.upcase(val) == "DROP" ->
        do_drop(stack)

      String.upcase(val) == "SWAP" ->
        do_swap(stack)

      String.upcase(val) == "OVER" ->
        do_over(stack)

      true ->
        Stack.push(stack, val)
    end
  end

  defp do_over(%Stack{} = stack) do
    {stack, operand1} = Stack.pop(stack)
    operand2 = Stack.peek(stack)

    if operand1 == nil || operand2 == nil do
      raise Forth.StackUnderflow
    else
      stack
      |> Stack.push(operand1)
      |> Stack.push(operand2)
    end
  end

  defp do_swap(%Stack{} = stack) do
    {stack, operand1} = Stack.pop(stack)
    {stack, operand2} = Stack.pop(stack)

    if operand1 == nil || operand2 == nil do
      raise Forth.StackUnderflow
    else
      stack
      |> Stack.push(operand1)
      |> Stack.push(operand2)
    end
  end

  defp do_drop(%Stack{} = stack) do
    case Stack.peek(stack) do
      nil -> raise Forth.StackUnderflow
      _ -> stack |> Stack.pop() |> elem(0)
    end
  end

  defp do_dup(%Stack{} = stack) do
    case Stack.peek(stack) do
      nil -> raise Forth.StackUnderflow
      _ -> stack |> Stack.push(Stack.peek(stack))
    end
  end

  defp do_arithmetic(%Stack{} = stack, operator) do
    {stack, operand1} = Stack.pop(stack)
    {stack, operand2} = Stack.pop(stack)

    val =
      case operator do
        :+ ->
          operand2 + operand1

        :- ->
          operand2 - operand1

        :* ->
          operand2 * operand1

        :/ ->
          if operand1 == 0 do
            raise Forth.DivisionByZero
          else
            div(operand2, operand1)
          end
      end

    Stack.push(stack, val)
  end

  defp is_int(s) do
    case Integer.parse(s) do
      {_, _} -> true
      _ -> false
    end
  end

  defp to_int(s) do
    Integer.parse(s) |> elem(0)
  end

  defp cleanse(s) do
    s
    |> String.to_charlist()
    |> Enum.map(fn c ->
      if c in 32..126, do: c, else: 32
    end)
    |> List.to_string()
  end
end
