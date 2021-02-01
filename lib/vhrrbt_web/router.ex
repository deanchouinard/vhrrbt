defmodule VhrRbtWeb.Router do
  use VhrRbtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VhrRbtWeb do
    pipe_through :api
    post "/env", ApiController, :env
    get "/env", ApiController, :env
    get "/ping", ApiController, :ping
  end
end
