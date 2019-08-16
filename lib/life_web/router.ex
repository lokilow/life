defmodule LifeWeb.Router do
  use LifeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", LifeWeb do
    pipe_through :browser
    live "/", LifeLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LifeWeb do
  #   pipe_through :api
  # end
end
