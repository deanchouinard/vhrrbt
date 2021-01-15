defmodule VhrRbt.Bme280Sensor do
  defstruct ~w[temp humid batt]a

  def read_sensor() do
    struct!(__MODULE__, %{temp: 70, humid: 50, batt: 75})

      #VhrRbt.SendData.send_env(%{temp: 70, humid: 50})
  end

end

