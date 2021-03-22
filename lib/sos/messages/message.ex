defmodule Sos.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :message_from, :string
    field :seen, :boolean, default: false
    field :text, :string
    belongs_to :chat, Sos.Chats.Chat
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:seen, :text, :message_from])
    |> validate_required([:seen, :text, :message_from])
  end
end
