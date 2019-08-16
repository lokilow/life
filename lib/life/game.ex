defmodule Life.Game do
  use GenServer

  def start_link(args) do
    IO.puts("starting new Game of Life")
    IO.inspect(args)
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(dimensions) do
    state = %{dimensions: dimensions, cell_map: %{}}
    Process.send_after(self(), :spawn_cells, 10)
    {:ok, state}
  end

  @impl true
  def handle_info(:spawn_cells, state) do
    IO.puts("spawning cells")
  end
end
