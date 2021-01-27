defmodule BMP do
  @moduledoc """
  Documentation for `BMP`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BMP.hello()
      :world

  """
  def hello do
    :world
  end  

  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end  

  # def start do
  #   {:ok, bmp} = BMP280.start_link(bus_name: "i2c-1", bus_address: 0x76)
  # end  


  def init(_) do
    {:ok, bmp} = BMP280.start_link(bus_name: "i2c-1", bus_address: 0x76)
    {:ok, %{bmp: bmp}}
  end


  def read do
    GenServer.cast(__MODULE__, {:read})
  end

  def handle_cast({:read}, state) do
    IO.inspect BMP280.read(state.bmp)
    {:noreply, state}
  end

end
  
