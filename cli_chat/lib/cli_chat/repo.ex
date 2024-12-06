defmodule CliChat.Repo do
  use Ecto.Repo,
    otp_app: :cli_chat,
    adapter: Ecto.Adapters.Postgres
end
