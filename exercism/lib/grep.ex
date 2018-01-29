defmodule Grep do
  def grep(content, options, files) do
    lines = files
      |> Enum.map
      |> File.stream!
      |> Enum.with_index
      |> Enum.filter(fn {line, _} -> line |> String.match?(build_regex(content, options)) end)
      |> process_line_numbers_flag(options)
      |> Enum.join("\n")
  end

  def build_regex(content, options) do
    if contains?(options, "-i") do
      ~r/#{content}/i
    else
      ~r/#{content}/
    end
  end

  def process_line_numbers_flag(lines, options) do
    if contains?(options, "-n") do
      lines |> Enum.map(fn {line, index} -> "#{index + 1}:#{line}" end)
    else
      lines |> Enum.map(fn {line, _} -> line end)
    end
  end

  def process_file_names_flag(lines, options) do
    if contains?(options, "-l") do

    end
  end

  def contains?(enum, val) do
    enum
      |> Enum.filter(fn x -> x == val end)
      |> Enum.count
      >= 1
  end
end
