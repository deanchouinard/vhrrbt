defmodule VhrRbtWeb.Router do
  use VhrRbtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    # plug Plug.Parsers, parsers: [:json],
    #                  pass:  ["text/*"],
    #                  json_decoder: Poison
  end

  scope "/api", VhrRbtWeb do
    pipe_through :api
    post "/env", ApiController, :env
    get "/env", ApiController, :env
    get "/ping", ApiController, :ping
    get "/take_picture", ApiController, :take_picture
    get "/mv_rbt", ApiController, :mv_rbt
    post "/move", ApiController, :move
  end
end
