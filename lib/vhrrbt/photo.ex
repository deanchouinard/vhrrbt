defmodule VhrRbt.Photo do

  def take_pic do
    System.cmd("raspistill", ["-n", "-q", "75", "-o", "3.jpg"], stderr_to_stdout: true)

  end

end

