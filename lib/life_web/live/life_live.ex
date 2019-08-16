defmodule LifeWeb.LifeLive do
  use Phoenix.LiveView

  def mount(args, socket) do
    initial_board = Life.Board.new()
    {:ok, assign(socket, :board, initial_board)}
  end

  def render(assigns) do
    Phoenix.View.render(LifeWeb.PageView, "index.html", assigns)
  end
end
