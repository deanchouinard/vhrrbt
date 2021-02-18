defmodule VhrRbt.VhrMove do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end


  def init(_) do
    #:timer.send_interval(50000, :ping)
    # {:ok, %SimpleCtrl{}}
    port = Port.open({:spawn, "python3 python_scripts/add.py"}, [:binary])
    {:ok, port}
  end

  def add(nums) do
    GenServer.call(__MODULE__, {:add, nums})
  end

  def handle_call({:add, nums}, _from, state) do
    # integers to a string
    msg =
      nums
      |> Enum.map(&to_string/1)
      |> Enum.join(",")

    #  sending the msg and ending "\n" as iolist
    Port.command(state, [msg, "\n"])

    # receive the result and convert to a string
    answer = receive do
      {^state, {:data, result}} ->
        String.trim(result)
        |> String.to_integer()
    end
    {:reply, answer, state}
  end
end