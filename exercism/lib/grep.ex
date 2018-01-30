defmodule Grep do
  def grep(content, options, files) do
    if Enum.count(files) == 1 do
      grep_one_file(content, options, List.first(files))
      |> Enum.join("")
    else
      files
      |> Enum.flat_map(fn file ->
        grep_one_file(content, options, file)
        |> process_file_names_flag_for_multi_files(options, file)
      end)
      |> Enum.join("")
    end
  end

  def process_file_names_flag_for_multi_files(lines, options, file) do
    if contains?(options, "-l") do
      lines
    else
      lines |> Enum.map(fn line -> "#{file}:#{line}" end)
    end
  end

  def grep_one_file(content, options, file) do
    file
    |> File.stream!()
    |> Enum.with_index()
    |> Enum.filter(fn {line, _} ->
      build_filter(line, build_regex(content, options), options)
    end)
    |> process_line_numbers_flag(options)
    |> process_file_names_flag(options, file)
  end

  def build_filter(line, regex, options) do
    if contains?(options, "-v") do
      !String.match?(line, regex)
    else
      String.match?(line, regex)
    end
  end

  def build_regex(content, options) do
    regex_option = if contains?(options, "-i"), do: "i", else: ""

    {:ok, regex} =
      if contains?(options, "-x") do
        Regex.compile("^#{content}$", regex_option)
      else
        Regex.compile("#{content}", regex_option)
      end

    regex
  end

  def process_line_numbers_flag(lines, options) do
    if contains?(options, "-n") do
      lines |> Enum.map(fn {line, index} -> "#{index + 1}:#{line}" end)
    else
      lines |> Enum.map(fn {line, _} -> line end)
    end
  end

  def process_file_names_flag(lines, options, file) do
    if contains?(options, "-l") && Enum.count(lines) > 0 do
      ["#{file}\n"]
    else
      lines
    end
  end

  def contains?(enum, val) do
    enum
    |> Enum.filter(fn x -> x == val end)
    |> Enum.count() >= 1
  end
end
