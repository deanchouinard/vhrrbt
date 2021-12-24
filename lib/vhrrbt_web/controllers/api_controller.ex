defmodule VhrRbtWeb.ApiController do
  @moduledoc """
  External API for the robot
  """
  alias VhrRbt.VhrMove
  use VhrRbtWeb, :controller

  def env(conn, params) do
    IO.inspect conn, label: "CONN"
    IO.inspect params, label: "PARAMS"
    #json(conn, %{id: "from /api/env"})
    json(conn, %{id: params["value"]})
  end

  def move(conn, params) do
    IO.inspect conn, label: "CONN"
    IO.inspect params, label: "PARAMS"
    {:ok, body, conn} = Plug.Conn.read_body(conn, length: 1_000_000)
    IO.inspect body, label: "BODY"
    body = Poison.decode! body
    IO.inspect body, label: "BODY"
    %{"dir" => dir, "mag" => mag} = body
    res = VhrMove.move_robot(dir, mag)
    #json(conn, %{id: "from /api/env"})
    json(conn, %{id: res})
  end

  def read_sensor(conn, params) do
    IO.inspect params, label: "READ_SENSOR"
    #%{"cmd" => cmd, "val" => val} = params
    #sum = VhrRbt.VhrPort.add [1,2,2]
    %VhrRbt.Sensor{temp: temp, humid: humid, batt: batt} =
      VhrRbt.Sensor.read()
    json(conn, %{id: "READ_SENSOR", temp: temp, humid: humid, batt: batt})
  end


  def mv_rbt(conn, params) do
    IO.inspect params, label: "MV_RBT"
    %{"cmd" => cmd, "val" => val} = params
    sum = VhrRbt.VhrPort.add [1,2,2]
    json(conn, %{id: "MV_RBT", sum: sum, cmd: cmd, val: val})
  end


  @doc """
  Simple ping/pong implementation. Use to check if he robot
  it there.
  """
  def ping(conn, _params) do
    text(conn, "PONG: " <> VhrRbt.current_datetime_string)
  end

  @doc """
  Receives a request to take a picture. Sends command to take a
  picture, and then returns the file name of the photo
  """
  def take_picture(conn, _params) do

    {{:ok, %HTTPoison.Response{request: request}}} =
      VhrRbt.SendData.send_photo()

    %HTTPoison.Request{body: {:multipart, [{_,_},
      {:file, filename, {_,[{_,_}, {_,_}]}, []} ]}} = request

    json(conn, %{filename: "#{filename}"})
  end

end
