defmodule CliChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CliChatWeb.Telemetry,
      CliChat.Repo,
      {DNSCluster, query: Application.get_env(:cli_chat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CliChat.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CliChat.Finch},
      # Start a worker by calling: CliChat.Worker.start_link(arg)
      # {CliChat.Worker, arg},
      # Start to serve requests, typically the last entry
      CliChatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CliChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CliChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
