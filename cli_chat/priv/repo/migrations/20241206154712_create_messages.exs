defmodule CliChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :room_id, references(:rooms, on_delete: :nothing)
      add :sender_id, references(:users, on_delete: :nothing)
      add :recipient_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:messages, [:room_id])
    create index(:messages, [:sender_id])
    create index(:messages, [:recipient_id])
  end
end
