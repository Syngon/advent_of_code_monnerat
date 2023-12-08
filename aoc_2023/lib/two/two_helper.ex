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
      |> Enum.map(&set_to_tuple/1)

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

  defp set_to_tuple(set) do
    set
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [number, color] -> {String.to_integer(number), color} end)
  end

  def get_max_cubes_from_each_game({game, games_subsets}) do
    max_cubes_from_each_game =
      games_subsets
      |> Enum.map(&String.split(&1, ", ", trim: true))
      |> Enum.map(&set_to_tuple/1)
      |> Enum.map(&get_max_cubes_from_each_subset/1)
      |> Enum.reduce(%{}, fn subset, acc ->
        blue = Map.get(subset, "blue", 0)
        green = Map.get(subset, "green", 0)
        red = Map.get(subset, "red", 0)

        acc
        |> maybe_add_value(blue, "blue")
        |> maybe_add_value(green, "green")
        |> maybe_add_value(red, "red")
      end)

    {game, max_cubes_from_each_game}
  end

  defp get_max_cubes_from_each_subset(subset) do
    Enum.reduce(subset, %{}, fn {number, color}, acc ->
      case Map.get(acc, color) do
        nil -> Map.put(acc, color, number)
        _ -> acc
      end
    end)
  end

  defp maybe_add_value(acc, color_value, color_name) do
    if Map.get(acc, color_name, 0) < color_value do
      Map.put(acc, color_name, color_value)
    else
      acc
    end
  end

  def multiply_cubes({game, max_cubes_from_each_game}) do
    values =
      max_cubes_from_each_game
      |> Map.values()
      |> Enum.reduce(1, fn value, acc -> acc * value end)

    {game, values}
  end
end
