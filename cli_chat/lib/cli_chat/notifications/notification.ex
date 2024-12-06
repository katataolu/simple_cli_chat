defmodule CliChat.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :seen, :boolean, default: false
    field :user_id, :id
    field :message_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:seen])
    |> validate_required([:seen])
  end
end
