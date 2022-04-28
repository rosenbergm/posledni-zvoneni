defmodule PZ.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PZ.Repo,
      PZ.MigrationRunner,
      # Start the Telemetry supervisor
      PZWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PZ.PubSub},
      # Start the Endpoint (http/https)
      PZWeb.Endpoint
      # Start a worker by calling: PZ.Worker.start_link(arg)
      # {PZ.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PZ.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PZWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
