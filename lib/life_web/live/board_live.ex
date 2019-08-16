defmodule LifeWeb.BoardLive do
  use Phoenix.LiveView

  def mount(args, socket) do
    {:ok, assign(socket, :board, args.board)}
  end

  def render(assigns) do
    Phoenix.View.render(LifeWeb.PageView, "board.html", assigns)
  end
end
