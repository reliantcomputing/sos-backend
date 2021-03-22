defmodule Sos.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :name, :string
#    field :ref, :string
    belongs_to :sit, Sos.Sits.Sit
    belongs_to :user, Sos.Accounts.User
    has_many :messages, Sos.Messages.Message
    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
