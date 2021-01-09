defmodule VhrRbtWeb.ApiController do
  use VhrRbtWeb, :controller

  def env(conn, params) do
    IO.inspect conn, label: "CONN"
    IO.inspect params, label: "PARAMS"
    #json(conn, %{id: "from /api/env"})
    json(conn, %{id: params["value"]})
  end
end
