defmodule VhrRbt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [VhrRbt.SendData,
      # Start the Telemetry supervisor
      VhrRbtWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VhrRbt.PubSub},
      # Start the Endpoint (http/https)
      VhrRbtWeb.Endpoint
      # Start a worker by calling: VhrRbt.Worker.start_link(arg)
      # {VhrRbt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VhrRbt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VhrRbtWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
