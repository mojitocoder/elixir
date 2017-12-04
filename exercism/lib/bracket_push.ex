defmodule BracketPush do
  def check_brackets(input) do
    input |> String.graphemes
          |> check_brackets([])
          |> Enum.empty?
  end

  def check_brackets([], stack) do
    stack
  end

  def check_brackets([head | tail], stack) do
    if head in ["[", "]", "(", ")", "{", "}"] do
      if head in ["[", "(", "{"] do
        check_brackets(tail, [head] ++ stack)
      else
        if Enum.empty?(stack) do
          [head]
        else
          if (head == "]" && hd(stack) == "[") ||
          (head == ")" && hd(stack) == "(") ||
          (head == "}" && hd(stack) == "{") do
            check_brackets(tail, tl(stack))
          else
            [head]
          end
        end
      end
    else
      check_brackets(tail, stack)
    end
  end
end
