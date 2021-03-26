defmodule VhrRbt.VhrMove do
  use GenServer

  @vhr_python_script   Application.get_env(:vhrrbt, :python_script)

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end


  def init(_) do
    #:timer.send_interval(50000, :ping)
    # {:ok, %SimpleCtrl{}}
    #port = Port.open({:spawn, "python3 python_scripts/add.py"}, [:binary])
    port = Port.open({:spawn, "python3 python_scripts/#{@vhr_python_script}"}, [:binary])
    {:ok, port}
  end

  def move_robot(cmd, mag) do
    GenServer.call(__MODULE__, {:move_robot, {cmd, mag}})
  end

  def add(nums) do
    GenServer.call(__MODULE__, {:add, nums})
  end

  def handle_call({:move_robot, {cmd, mag}}, _from, state) do
    cmd = cmd <> "," <> mag
    Port.command(state, [cmd, "\n"])
    answer = receive do
      {^state, {:data, result}} ->
        String.trim(result)
        #    |> String.to_integer()
    end
    {:reply, answer, state}
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
