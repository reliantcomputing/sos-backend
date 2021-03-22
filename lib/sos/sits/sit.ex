defmodule Sos.Sits.Sit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sits" do
    field :sit_number, :string
    has_many :chats, Sos.Chats.Chat
    has_many :orders, Sos.Orders.Order
    timestamps()
  end

  @doc false
  def changeset(sit, attrs) do
    sit
    |> cast(attrs, [:sit_number])
    |> validate_required([:sit_number])
  end
end
