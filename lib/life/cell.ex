defmodule Life.Cell do
  @alive 1
  @dead 0
  defstruct alive?: false, neighbors: nil

  def start do
    spawn(fn -> loop(%{alive?: 0, neighbors: nil}) end)
  end

  def loop(cell) do
    receive do
      {:add_neighbors, pids} ->
        cell = add_neighbors(cell, pids)
        IO.inspect(cell)
        loop(cell)

      {:neighbor_status, from, status} ->
        cell = update_neighbor_status(cell, from, status)
        IO.inspect(cell)
        alive = is_cell_alive(cell)

        cond do
          alive == cell.alive? ->
            loop(cell)

          true ->
            cell = %{cell | alive?: alive}
            notify_neighbors(cell)
            loop(cell)
        end
    end
  end

  defp add_neighbors(cell, pids) do
    neighbors =
      for neighbor <- pids, into: %{} do
        {neighbor, @dead}
      end

    %{cell | neighbors: neighbors}
  end

  defp update_neighbor_status(cell, neighbor, status) do
    neighbors = Map.put(cell.neighbors, neighbor, status)
    %{cell | neighbors: neighbors}
  end

  defp is_cell_alive(cell) do
    num_alive_neighbors = Map.values(cell.neighbors) |> Enum.sum()

    cond do
      num_alive_neighbors < 2 -> @dead
      num_alive_neighbors > 3 -> @dead
      num_alive_neighbors == 3 -> @alive
      num_alive_neighbors == 2 && cell.alive? == @alive -> @alive
    end
  end

  defp notify_neighbors(cell) do
    Enum.each(cell.neighbors, fn {k, _v} -> send(k, {:neighbor_status, self(), cell.alive?}) end)
  end
end
