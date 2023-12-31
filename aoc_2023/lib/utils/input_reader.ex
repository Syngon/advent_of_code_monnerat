defmodule Aoc2023.InputReader do
  @moduledoc false
  @doc """
  Read the input file and return a list of lines.
  """
  @spec read_input!(module) :: binary
  def read_input!(module) do
    day =
      module
      |> Module.split()
      |> List.last()
      |> String.replace("Solution", "")
      |> String.downcase()

    file_name = "../#{day}/input.txt"
    path = Path.expand(file_name, __DIR__)
    File.read!(path)
  end
end
