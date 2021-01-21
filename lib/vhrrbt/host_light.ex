defmodule VhrRbt.HostLightImpl do
  @behaviour VhrRbt.Light
  require Logger

  @impl VhrRbt.Light
  def init(_) do
    {:ok, :off}
  end

  @impl VhrRbt.Light
  def off(:off), do: IO.puts "off" #:ok
  def off(:on) do
    IO.puts "host"
    Logger.debug "changing light from :on to :off"
    :ok
  end

  @impl VhrRbt.Light
  def on(:on), do: :ok
  def on(:off) do
    Logger.debug "changing light from :off to :on"
    :ok
  end
end
