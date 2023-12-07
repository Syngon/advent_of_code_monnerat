defmodule Aoc2023.OneHelper do
  @moduledoc false

  @numbers ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @numbers_spelled ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

  def get_numbers_from_line(line) do
    numbers_list =
      line
      |> String.split("", trim: true)
      |> Enum.reject(&Regex.match?(~r/\D/, &1))
      |> Enum.map(&String.to_integer/1)

    first_digit = Enum.at(numbers_list, 0)
    second_digit = Enum.at(numbers_list, length(numbers_list) - 1)

    full_number = Integer.to_string(first_digit) <> Integer.to_string(second_digit)
    String.to_integer(full_number)
  end

  def get_all_numbers(line) do
    numbers_list =
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) in @numbers))

    numbers_spelled_in_line = Enum.filter(@numbers_spelled, &String.contains?(line, &1))

    spelled_numbers_list =
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(&get_written_numbers_in_line(&1, line, numbers_spelled_in_line))
      |> Enum.reject(&Enum.empty?/1)
      |> List.flatten()

    numbers_list ++ spelled_numbers_list
  end

  def get_written_numbers_in_line({charactere, index}, line, numbers_spelled_in_line)
      when charactere not in @numbers_spelled do
    numbers_spelled_in_line
    |> Enum.map(&add_number_if_substring_is_number(&1, line, index))
    |> Enum.reject(&is_nil/1)
  end

  def add_number_if_substring_is_number(number, line, index) do
    number_length = String.length(number)
    possible_text = String.slice(line, index, number_length)

    if possible_text == number do
      {number, index}
    end
  end

  def get_min_max_from_list(list) do
    Enum.min_max_by(list, &elem(&1, 1))
  end

  def convert_tuple_min_max_to_integer({{str_min_value, _min_index}, {str_max_value, _max_index}}) do
    min_value = to_integer(str_min_value)
    max_value = to_integer(str_max_value)

    value_concat = Integer.to_string(min_value) <> Integer.to_string(max_value)
    String.to_integer(value_concat)
  end

  def to_integer("one"), do: 1
  def to_integer("two"), do: 2
  def to_integer("three"), do: 3
  def to_integer("four"), do: 4
  def to_integer("five"), do: 5
  def to_integer("six"), do: 6
  def to_integer("seven"), do: 7
  def to_integer("eight"), do: 8
  def to_integer("nine"), do: 9
  def to_integer("zero"), do: 0
  def to_integer(number), do: String.to_integer(number)
end
