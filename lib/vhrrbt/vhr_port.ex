defmodule VhrRbt.VhrPort do

  def hello do
    # port = Port.open({:spawn, "python3 hello.py"}, [:binary])
    port = Port.open({:spawn, "python3"}, [:binary])
    #    port = Port.open({:spawn, "python3"}, [])
    #    send(port, {self(), {:command, "hello"}})
    send(port, {self(), {:command, "print(\"world\");\n"}})
    #send(port, {self(), {:command, "quit()"}})
    #send(port, {self(), :close})

  end

  def add() do

    # add = fn port, nums ->
    nums = [1,2,3,4,5]
    port = Port.open({:spawn, "python3 python_scripts/add.py"}, [:binary])
    # integers to a string
    msg =
      nums
      |> Enum.map(&to_string/1)
      |> Enum.join(",")

    #  sending the msg and ending "\n" as iolist
    Port.command(port, [msg, "\n"])

    # receive the result and convert to a string
    receive do
      {^port, {:data, result}} ->
        String.trim(result)
        |> String.to_integer()
    end
    #send(port, {self(), :close})
  end


end

