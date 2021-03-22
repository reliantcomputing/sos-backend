defmodule Sos.OrderItems.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :price, :decimal
    field :qty, :integer
    belongs_to :order, Sos.Orders.Order
    belongs_to :menu, Sos.Menus.Menu
    belongs_to :extra, Sos.Extras.Extra
    timestamps()
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:qty, :price])
    |> validate_required([:qty, :price])
  end
end
