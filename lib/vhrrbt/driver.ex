defmodule VhrRbt.Driver do
  @moduledoc """
  Runs on start up, and issues periodic commands
  """

  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def ping() do
    #GenServer.info(__MODULE__, {:ping})
    send(__MODULE__, :ping)
  end

  def init(_) do
    #:timer.send_interval(50000, :ping)
    # {:ok, %SimpleCtrl{}}
    {:ok, []}
  end

  def handle_info(:ping, state) do
    vdate = VhrRbt.current_datetime_string()
    external_ip = VhrRbt.NetInfo.external_ip
    %VhrRbt.Sensor{temp: temp, humid: humid, batt: batt} =
       VhrRbt.Sensor.read()

    body = "{\"date\" : \"#{vdate}\", \"ext_ip\" : \"#{external_ip}\",
      \"temp\" : #{temp}, \"humid\" : #{humid}, \"batt\" : #{batt}}"
    
    VhrRbt.SendData.send_env(body)
    IO.puts "Ping..."
    {:noreply, state}
  end


end

