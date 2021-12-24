defmodule VhrRbt.NetInfo do
  @moduledoc """
  VhrRbt.NetInfo reports networking information.
  """

  @doc """
  Returns external IP address of the robot
  """
  def external_ip do
    {:ok, {_, _, inet_addr}} = :httpc.request('http://api.ipify.org')
    inet_addr
  end
end
