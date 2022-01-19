defmodule PhotoTask do
  #use Task
  @vhr_web_url   Application.get_env(:vhrrbt, :send_data_url)

  def start_link(arg) do
    IO.puts "PhotoTask start_link"
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_arg) do
    IO.puts "PhotoTask run"
    _headers = ""
    _options = ""
    url = "#{@vhr_web_url}/photo"
    file_name = VhrRbt.current_datetime_string()
      |> String.replace(" ", "")
      |> String.replace(":", "")
    file_name = file_name <> ".jpg"
    VhrRbt.Photo.take_pic(file_name)

    IO.puts "FILE NAME"
    IO.puts "URL: #{url}"

    _response = HTTPoison.post(url, {:multipart, [{"id", "87937"}, {:file, file_name, {"form-data", [{"name", "photo"}, {"filename", Path.basename(file_name)}]}, []}]})

    IO.puts "AFTER POST"
    File.rm(file_name)


  end
end
