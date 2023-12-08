defmodule Aoc2023.TwoHelper do
  @moduledoc false

  @max_red 12
  @max_green 13
  @max_blue 14

  def split_line(line) do
    [game, sets] =
      line
      |> String.split(": ", trim: true)
      |> Enum.map(&String.trim/1)

    {game, sets}
  end

  def handle_games_names({game, sets}) do
    game_index =
      game
      |> String.split(" ", trim: true)
      |> Enum.at(1)
      |> String.to_integer()

    {game_index, sets}
  end

  def split_cubes({game, sets}) do
    games_subsets = String.split(sets, "; ", trim: true)
    {game, games_subsets}
  end

  def split_subsets({game, games_sets}) do
    games_subsets =
      games_sets
      |> Enum.map(&String.split(&1, ", ", trim: true))
      |> Enum.map(fn set ->
        set
        |> Enum.map(&String.split(&1, " ", trim: true))
        |> Enum.map(fn [number, color] -> {String.to_integer(number), color} end)
      end)

    {game, games_subsets}
  end

  def filter_games({game, games_subsets}) do
    Enum.all?(games_subsets, &is_valid_subset?/1)
  end

  def is_valid_subset?(subset) do
    Enum.all?(subset, fn {number, color} -> is_valid_cube?(number, color) end)
  end

  defp is_valid_cube?(number, color) do
    case color do
      "red" -> number <= @max_red
      "green" -> number <= @max_green
      "blue" -> number <= @max_blue
    end
  end
end
