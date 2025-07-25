defmodule GtdCalc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GtdCalcWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:gtd_calc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GtdCalc.PubSub},
      # Start a worker by calling: GtdCalc.Worker.start_link(arg)
      # {GtdCalc.Worker, arg},
      # Start to serve requests, typically the last entry
      GtdCalcWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GtdCalc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GtdCalcWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
