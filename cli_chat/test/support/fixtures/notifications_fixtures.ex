defmodule CliChat.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CliChat.Notifications` context.
  """

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        seen: true
      })
      |> CliChat.Notifications.create_notification()

    notification
  end
end
