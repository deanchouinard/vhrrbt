defmodule CmdProc do
  def docmd({:f = direction, movement} = cmd) do
    move_robot(direction, movement)
    IO.puts "#{direction} : #{movement}"
  end

  def docmd("B" = cmd) do
    IO.puts "B"
  end

  def docmd(_) do
    IO.puts "DEFAULT"
  end

  def move_robot(direction, 
end

CmdProc.docmd({F, 2})
CmdProc.docmd("B")
CmdProc.docmd("G")

