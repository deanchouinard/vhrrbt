defmodule VhrRbt.NetInfo do

  def external_ip do
    #    :inets.start
    {:ok, {_, _, inet_addr}} = :httpc.request('http://api.ipify.org')
    # :inets.stop
    inet_addr
  end
end

