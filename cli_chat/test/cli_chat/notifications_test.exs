defmodule CliChat.NotificationsTest do
  use CliChat.DataCase

  alias CliChat.Notifications

  describe "notifications" do
    alias CliChat.Notifications.Notification

    import CliChat.NotificationsFixtures

    @invalid_attrs %{seen: nil}

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Notifications.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Notifications.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      valid_attrs = %{seen: true}

      assert {:ok, %Notification{} = notification} =
               Notifications.create_notification(valid_attrs)

      assert notification.seen == true
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      update_attrs = %{seen: false}

      assert {:ok, %Notification{} = notification} =
               Notifications.update_notification(notification, update_attrs)

      assert notification.seen == false
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Notifications.update_notification(notification, @invalid_attrs)

      assert notification == Notifications.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Notifications.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Notifications.change_notification(notification)
    end
  end
end
