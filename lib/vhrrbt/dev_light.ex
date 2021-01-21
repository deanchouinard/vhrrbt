defmodule VhrRbt.ElixirAleLightImpl do
  @behaviour VhrRbt.Light
  require Logger

  @impl VhrRbt.Light
  def init(args) do
    pin = Keyword.fetch!(args, :pin)
    # {:ok, pid} = ElixirAle.GPIO.start_link(pin, :output)
    pid = 99
    {:ok, %{pid: pid, pin: pin, state: :off}}
  end

  @impl VhrRbt.Light
  def off(%{state: :off}), do: :ok
  def off(:on) do
    Logger.debug "changing light from :on to :off"
    # ElixirAle.GPIO.write(pid, 1)
  end

  @impl VhrRbt.Light
  def on(%{state: :on}), do: :ok
  def on(:off) do
    Logger.debug "changing light from :off to :on"
    # ElixirAle.GPIO.write(pid, 0)
  end
end

