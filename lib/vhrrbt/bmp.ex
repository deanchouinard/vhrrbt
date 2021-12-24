defmodule VhrRbt.BMP do
  @moduledoc """
  VhrRbt.BMP communicates with the BMP280 sensor.
  """
  #  use GenServer

  @behaviour VhrRbt.Sensor

  # def start do
  #   GenServer.start(__MODULE__, nil, name: __MODULE__)
  # end

  # def start do
  #   {:ok, bmp} = BMP280.start_link(bus_name: "i2c-1", bus_address: 0x76)
  # end

  @impl VhrRbt.Sensor
  def init(_) do
    {:ok, bmp} = BMP280.start_link(bus_name: "i2c-1", bus_address: 0x76)
    #{:ok, %{bmp: bmp}}
    {:ok, bmp}
  end

  @impl VhrRbt.Sensor
  def read(bmp) do
    {:ok, %BMP280.Measurement{
      humidity_rh: humid,
      temperature_c: temp}} = BMP280.read(bmp)
    temp = (temp * 9/5) + 32 |> Float.round(2)
    humid = Float.round(humid, 2)
    env_data = struct!(VhrRbt.Sensor, %{temp: temp, humid: humid, batt: 75})
    {:ok, env_data}
  end

  # def handle_call({:read}, _from, state) do
  #   {:ok, %BMP280.Measurement{
  #     humidity_rh: humid,
  #     temperature_c: temp}} = BMP280.read(state.bmp)
  #   env_data = struct!(VhrRbt.Sensor, %{temp: temp, humid: humid, batt: 75})
  #   {:reply, env_data, state}
  # end
end
