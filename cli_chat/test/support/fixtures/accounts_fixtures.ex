defmodule CliChat.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CliChat.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hashed_password: "some hashed_password",
        username: "some username"
      })
      |> CliChat.Accounts.create_user()

    user
  end
end
