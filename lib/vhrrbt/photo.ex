defmodule VhrRbt.Photo do

  def take_pic(filename) do
    # filename = filename <> ".jpg"
    # System.cmd("raspistill", ["-n", "-q", "75", "-o", filename], stderr_to_stdout: true)
    System.cmd("raspistill", ["-n", "-q", "50", "-o", filename], stderr_to_stdout: true)

  end

end

