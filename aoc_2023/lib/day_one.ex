defmodule Aoc2023.One do
  @moduledoc false
  alias Aoc2023.InputReader
  alias Aoc2023.OneHelper

  @doc """
    Day One of advent of code 2023.
  """
  def one do
    _input_test = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    __MODULE__
    |> InputReader.read_input!()
    |> String.split("\n", trim: true)
    |> Enum.map(&OneHelper.get_numbers_from_line/1)
    |> Enum.sum()
  end

  def two do
    _input_test = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    __MODULE__
    |> InputReader.read_input!()
    |> String.split("\n", trim: true)
    |> Enum.map(&OneHelper.get_all_numbers/1)
    |> Enum.map(&OneHelper.get_min_max_from_list/1)
    |> Enum.map(&OneHelper.convert_tuple_min_max_to_integer/1)
    |> Enum.sum()
  end
end
