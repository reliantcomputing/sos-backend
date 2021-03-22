defmodule SosWeb.MessageView do
  use SosWeb, :view
  alias SosWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      seen: message.seen,
      text: message.text,
      message_from: message.message_from}
  end
end
