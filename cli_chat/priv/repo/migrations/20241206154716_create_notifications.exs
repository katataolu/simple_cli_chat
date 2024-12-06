defmodule CliChat.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :seen, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :message_id, references(:messages, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:notifications, [:user_id])
    create index(:notifications, [:message_id])
  end
end
