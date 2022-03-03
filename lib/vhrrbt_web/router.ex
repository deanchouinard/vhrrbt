defmodule VhrRbtWeb.Router do
  use VhrRbtWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {VhrCtlWeb.LayoutView, :root}
  end

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
    get "/read_sensor", ApiController, :read_sensor
  end
  
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: VhrCtlWeb.Telemetry
    end
  end
end
