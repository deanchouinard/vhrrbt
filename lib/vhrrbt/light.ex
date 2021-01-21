defmodule VhrRbt.Light do

  #@opaque private :: term
  @type private :: term

  @doc "initialize the light"
  @callback init(opts :: Keyword.t()) :: {:ok, private} | :error

  @doc "Callback to turn the light on"
  @callback on(private) :: :ok | :error

  @doc "Callback to turn the light off"
  @callback off(private) :: :ok | :error

  use GenServer

  @args Application.get_env(:vhrrbt, __MODULE__)

  def on(pid \\ __MODULE__) do
    GenServer.cast(pid, :on)
  end

  def off(pid \\ __MODULE__) do
    GenServer.cast(pid, :off)
  end

  def start_link(args \\ @args, opts \\ [name: __MODULE__]) do
    #GenServer.start_link(__MODULE__, args, opts)
    GenServer.start_link(__MODULE__, @args, [name: __MODULE__])
  end

  def init(args) do
    impl = Keyword.fetch!(args, :implementation)
    IO.inspect impl, label: "IMPL"
    {:ok, priv} = impl.init(args)
    {:ok, %{impl: impl, priv: priv}}
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

