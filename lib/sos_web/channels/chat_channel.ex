defmodule SosWeb.ChatChannel do
  use SosWeb, :channel

  @impl true
  def join("chat", _payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("create:chat", payload, socket) do
    sit_number = payload["sit_number"]
    sit = Sos.Sits.get_by_sit_number(sit_number)
    broadcast(socket,"create:chat", %{
      sit_number: sit.sit_number,
      waiting: true
    })
    {:reply, :ok, socket}
  end

  @impl true
  def handle_in("accept:chat", payload, socket) do
    # Get data from the payload
    sit_number = payload["sit_number"]
    waiter_id = payload["waiter_id"]

    # Get dependency data
    waiter = Sos.Accounts.get_user!(waiter_id)
    sit = Sos.Sits.get_by_sit_number(sit_number)
    ref = Sos.Randomizer.randomizer(8)

    chat = %{ name: "#{ref} - sit ##{sit.sit_number}" }
    with {:ok, chat} <- Sos.Chats.create_chat(waiter, chat) do
      name = "#{waiter.last_name} #{waiter.first_name}"
      broadcast(socket, "accept:chat", %{
        chat: %{
          id: chat.id,
          ref: ref,
          sit_number: sit.sit_number,
          name: chat.name,
          messages: [],
          waiter: %{
            name: name
          }
        }
      })
      {:reply, :ok, socket}
    end
  end

  @impl true
  def handle_in("send:message:"<>chat_id, payload, socket) do
    IO.inspect("=======================================")
    IO.inspect(chat_id)
    IO.inspect("=======================================")
    chat = Sos.Chats.get_chat!(chat_id)
    message_from = payload["message_from"]
    with{:ok, message} <- Sos.Messages.create_message(chat, payload) do
    IO.inspect("=======================================")
      broadcast(socket, "send:message:#{chat_id}", %{
        _id: message.id,
        chatId: chat_id,
        text: message.text,
        seen: false,
        user: %{
          _id: message(message_from),
        },
        message_from: message.message_from
      })
      {:reply, :ok, socket}
    end
    {:noreply, socket}
  end

  @impl true
  def handle_in("cancel:chat:"<>chat_id, _payload, socket) do
    chat = Sos.Chats.get_chat!(chat_id)
    canceled = %{canceled: true}
    with{:ok, _} <- Sos.Chats.update_chat(chat, canceled) do
      broadcast(socket, "cancel:chat:"<>chat_id, %{
        chatId: chat.id
      })
    end
  end

  defp message(from) do
    if from == "WAITER" do
      0
    else
      1
    end
  end
end
