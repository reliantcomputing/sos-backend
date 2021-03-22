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
    sit_id = payload["sit_id"]
    sit = Sos.Sits.get_sit!(sit_id)
    broadcast(socket,"create:chat", %{
      sit_number: sit.sit_number
    })
    {:reply, :ok, socket}
  end

  @impl true
  def handle_in("accept:chat", payload, socket) do
    # Get data from the payload
    sit_id = payload["sit_id"];
    waiter_id = payload["waiter_id"]

    # Get dependency data
    waiter = Sos.Accounts.get_user!(waiter_id)
    sit = Sos.Sits.get_sit!(sit_id)
    ref = Sos.Randomizer.randomizer(8)

    chat = %{ name: "#{ref} - sit:#{sit.sit_number}" }
    with {:ok, chat} <- Sos.Chats.create_chat(waiter, chat) do
      broadcast(socket, "accept:chat", %{
        chat: %{
          id: chat.id,
          ref: ref,
          name: chat.name,
          messages: []
        }
      })
      {:reply, :ok, socket}
    end
  end

  @impl true
  def handle_in("send:message:"<>chat_id, payload, socket) do
    chat = Sos.Chats.get_chat!(chat_id)
    with{:ok, message} <- Sos.Messages.create_message(chat, payload) do
      broadcast(socket, "send:message:"<>chat_id, %{
        id: message.id,
        chatId: chat_id,
        text: message.text,
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
end
