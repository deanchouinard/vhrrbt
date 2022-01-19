defmodule VhrRbt.Photo do
  @moduledoc "Takes the photos"

  def take_pic(filename) do
    # filename = filename <> ".jpg"
    # System.cmd("raspistill", ["-n", "-q", "75", "-o", filename], stderr_to_stdout: true)

    IO.puts "file copy"

    case Mix.target() do
      :host ->
        File.cp!("hot-dog.jpg", filename)
      :rpi3 ->
        System.cmd("raspistill", ["-n", "-q", "50", "-o", filename], stderr_to_stdout: true)
    end

  end

end
