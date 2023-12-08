defmodule Aoc2023.TwoSolution do
  @moduledoc false

  alias Aoc2023.InputReader
  alias Aoc2023.TwoHelper

  def one do
    _input_test = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    __MODULE__
    |> InputReader.read_input!()
    |> String.split("\n", trim: true)
    |> Enum.map(&TwoHelper.split_line/1)
    |> Enum.map(&TwoHelper.handle_games_names/1)
    |> Enum.map(&TwoHelper.split_cubes/1)
    |> Enum.map(&TwoHelper.split_subsets/1)
    |> Enum.filter(&TwoHelper.filter_games/1)
    |> Enum.reduce(0, fn {index, _}, acc -> acc + index end)
  end

  def two do
    _input_test = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    __MODULE__
    |> InputReader.read_input!()
    |> String.split("\n", trim: true)
    |> Enum.map(&TwoHelper.split_line/1)
    |> Enum.map(&TwoHelper.handle_games_names/1)
    |> Enum.map(&TwoHelper.split_cubes/1)
    |> Enum.map(&TwoHelper.get_max_cubes_from_each_game/1)
    |> Enum.map(&TwoHelper.multiply_cubes/1)
    |> Enum.reduce(0, fn {_game, multiplied_value}, acc -> acc + multiplied_value end)
  end
end
