defmodule CliChat.CLI do
  alias CliChat.Repo
  alias CliChat.Accounts.User
  alias CliChat.Chat.Room
  alias CliChat.Chat.Message

  def run(["create_user", username, email, password]) do
    hashed_password = Bcrypt.hash_pwd_salt(password)
    user = %User{username: username, email: email, hashed_password: hashed_password}

    case Repo.insert(user) do
      {:ok, _} -> IO.puts("User #{username} created successfully.")
      {:error, changeset} -> IO.inspect(changeset.errors)
    end
  end

  def run(["create_room", room_name]) do
    room = %Room{name: room_name}

    case Repo.insert(room) do
      {:ok, _} -> IO.puts("Room '#{room_name}' created successfully.")
      {:error, changeset} -> IO.inspect(changeset.errors)
    end
  end

  def run(["send_message", sender_id, room_id, content]) do
    case Repo.get(User, String.to_integer(sender_id)) do
      nil ->
        IO.puts("Sender with ID #{sender_id} does not exist.")

      sender ->
        case Repo.get(Room, String.to_integer(room_id)) do
          nil ->
            IO.puts("Room with ID #{room_id} does not exist.")

          room ->
            message = %Message{
              sender_id: sender.id,
              room_id: room.id,
              content: content
            }

            case Repo.insert(message) do
              {:ok, _} -> IO.puts("Message sent to room '#{room.name}' successfully.")
              {:error, changeset} -> IO.inspect(changeset.errors)
            end
        end
    end
  end

  def run(_) do
    IO.puts("""
    #{IO.ANSI.red()}Invalid command.#{IO.ANSI.reset()} Available commands:

    #{IO.ANSI.green()}- create_user <username> <email> <password>#{IO.ANSI.reset()}
        Create a new user with the given username, email, and password.

    #{IO.ANSI.yellow()}- create_room <room_name>#{IO.ANSI.reset()}
        Create a new chat room with the specified name.

    #{IO.ANSI.blue()}- send_message <sender_id> <room_id> <content>#{IO.ANSI.reset()}
        Send a message to the specified room from the sender.
    """)
  end
end
