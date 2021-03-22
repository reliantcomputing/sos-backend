defmodule Sos.OrderMenus.OrderMenu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_menus" do
    field :qty, :integer
    timestamps()
    belongs_to :order, Sos.Orders.Order
    belongs_to :menu, Sos.Menus.Menu
  end

  @doc false
  def changeset(order_menu, attrs) do
    order_menu
    |> cast(attrs, [:qty])
    |> validate_required([:qty])
  end
end
