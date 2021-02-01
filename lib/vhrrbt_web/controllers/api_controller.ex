defmodule VhrRbtWeb.ApiController do
  use VhrRbtWeb, :controller

  def env(conn, params) do
    IO.inspect conn, label: "CONN"
    IO.inspect params, label: "PARAMS"
    #json(conn, %{id: "from /api/env"})
    json(conn, %{id: params["value"]})
  end

  def ping(conn, _params) do
    text(conn, "PONG: " <> VhrRbt.current_datetime_string)
  end

end
