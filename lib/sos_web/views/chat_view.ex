defmodule SosWeb.ChatView do
  use SosWeb, :view
  alias SosWeb.ChatView

  def render("index.json", %{chats: chats}) do
    %{data: render_many(chats, ChatView, "chat.json")}
  end

  def render("show.json", %{chat: chat}) do
    %{data: render_one(chat, ChatView, "chat.json")}
  end

  def render("chat.json", %{chat: chat}) do
    %{id: chat.id,
      name: chat.name}
  end
end
