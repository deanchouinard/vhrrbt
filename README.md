# VhrRbt
Program that runs on the robot. Receives and executes commands; sends
environmental, photographs, and status data out.

To start in development mode on host:

    iex -S mix phx.server

Runs at:

    http://localhost:4500

Development mode on robot device:

    MIX_TARGET=rpi3 iex -S mix phx.server

Runs at:

    http://192.168.0.184:4500

