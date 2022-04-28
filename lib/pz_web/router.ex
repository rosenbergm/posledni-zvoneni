defmodule PZWeb.Router do
  use PZWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PZWeb do
    pipe_through :api

    get "/classes", ClassesController, :get
    get "/countries", CountriesController, :get
    get "/transfers", TransfersController, :get
    post "/transfers", TransfersController, :add
  end
end
