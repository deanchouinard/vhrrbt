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

  def take_picture(conn, _params) do

    IO.puts "TAKE PICTURE"
    {{:ok, %HTTPoison.Response{request: request}}} = VhrRbt.SendData.send_photo()
    %HTTPoison.Request{body: {:multipart, [{_,_},
      {:file, filename, {_,[{_,_}, {_,_}]}, []} ]}} = request

    IO.inspect filename, label: "SEND_PHOTO"
    json(conn, %{filename: "#{filename}"})
  end

end
