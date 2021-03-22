defmodule Sos.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :rejected, :boolean, default: false
    field :rejected_reason, :string
    field :status, :string
    belongs_to :sit, Sos.Sits.Sit
    has_many :order_extras, Sos.OrderExtras.OrderExtra
    has_many :order_menus, Sos.OrderMenus.OrderMenu
    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :rejected, :rejected_reason])
    |> validate_required([:status, :rejected])
  end
end
