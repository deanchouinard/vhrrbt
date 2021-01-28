defmodule VhrRbt.Sensor do
  defstruct ~w[temp humid batt]a

  #@opaque private :: term
  @type private :: term

  @doc "initialize the light"
  @callback init(opts :: Keyword.t()) :: {:ok, private} | :error

  @doc "Callback to read sensor"
  @callback read() :: {:ok, __MODULE__} | :error

  use GenServer

  @args Application.get_env(:vhrrbt, __MODULE__)

  def read(pid \\ __MODULE__) do
    GenServer.call(pid, :read)
  end

  def on(pid \\ __MODULE__) do
    GenServer.cast(pid, :on)
  end

  def off(pid \\ __MODULE__) do
    GenServer.cast(pid, :off)
  end

  def start_link(args \\ @args, opts \\ [name: __MODULE__]) do
    IO.inspect args, label: "ARGS"
    IO.inspect @args, label: "@ARGS"
    IO.inspect opts, label: "OPTS"
    #GenServer.start_link(__MODULE__, args, opts)
    GenServer.start_link(__MODULE__, @args, [name: __MODULE__])
  end

  def init(args) do
    impl = Keyword.fetch!(args, :implementation)
    IO.inspect impl, label: "IMPL"
    {:ok, priv} = impl.init(args)
    IO.inspect priv, label: "PRIV"
    {:ok, %{impl: impl, priv: priv}}
  end

  def handle_call(:read, _from, state) do
    {:ok, env_data} = state.impl.read()
    #{:noreply, %{state | priv: :on}}
    {:reply, env_data, state}
  end

  def handle_cast(:on, state) do
    :ok = state.impl.on(state.priv)
    {:noreply, %{state | priv: :on}}
  end

  def handle_cast(:off, state) do
    :ok = state.impl.off(state.priv)
    {:noreply, %{state | priv: :off}}
  end
end

