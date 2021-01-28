defmodule VhrRbt.BME do

  @behaviour VhrRbt.Sensor

  @impl VhrRbt.Sensor
  def init(_) do
    {:ok, :off}
    end

  @impl VhrRbt.Sensor
  def read() do
    {:ok, struct!(VhrRbt.Sensor, %{temp: 70, humid: 50, batt: 75})}
    #    IO.puts "read"
      #VhrRbt.SendData.send_env(%{temp: 70, humid: 50})
  end

end

