defmodule Sos.OrderExtras.OrderExtra do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_extras" do
    field :qty, :integer
    timestamps()

    belongs_to :order, Sos.Orders.Order
    belongs_to :extra, Sos.Extras.Extra
  end

  @doc false
  def changeset(order_extra, attrs) do
    order_extra
    |> cast(attrs, [:qty])
    |> validate_required([:qty])
  end
end
