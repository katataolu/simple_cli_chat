defmodule CliChat.RoomUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "room_users" do
    field :user_id, :id
    field :room_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(room_user, attrs) do
    room_user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
