defmodule ElixirBadges.Router do
  use Phoenix.Router

  # Removed all plugs and pipelines, that are not needed.

  pipeline :browser do
    plug :accepts, ["html"]
    #plug :fetch_session
    #plug :fetch_flash
    #plug :protect_from_forgery
  end

  #pipeline :api do
  #  plug :accepts, ["json"]
  #end

  scope "/", ElixirBadges do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/badges/:name", ElixirBadges do

    get "/licenses.svg", BadgeController, :licenses
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirBadges do
  #   pipe_through :api
  # end
end
