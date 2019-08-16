defmodule Life do
  @moduledoc """
  Conway's game of life.  Implemented in processes.
  """

  @doc """
  """
  def new_game({columns, rows}) do
    {:ok, {columns, rows}}
  end

  defmodule Board do
    defstruct dimensions: nil, cells: nil

    def new(columns \\ 8, rows \\ 8, points \\ []) do
      cells =
        for col <- 1..columns, row <- 1..rows, into: %{} do
          {{col, row}, 0}
        end

      cells =
        Enum.reduce(points, cells, fn p, acc ->
          %{acc | p => 1}
        end)

      %__MODULE__{dimensions: %{columns: columns, rows: rows}, cells: cells}
    end

    def calculate_neighbors(dimensions, column, row) do
      {columns, rows} = dimensions

      neighbors =
        for x <- -1..1, y <- -1..1, into: MapSet.new() do
          neighbor_col = calculate_coordinate(column + x, columns)
          neighbor_row = calculate_coordinate(row + y, rows)

          {neighbor_col, neighbor_row}
        end

      MapSet.delete(neighbors, {column, row})
    end

    defp calculate_coordinate(coord, modulo) when coord == 0, do: modulo
    defp calculate_coordinate(coord, modulo) when coord > modulo, do: 1
    defp calculate_coordinate(coord, _modulo), do: coord
  end
end
