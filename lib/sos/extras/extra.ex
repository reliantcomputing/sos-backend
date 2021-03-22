defmodule Sos.Extras.Extra do
  use Ecto.Schema
  import Ecto.Changeset

  schema "extras" do
    field :description, :string
    field :image, :string
    field :price, :decimal
    field :title, :string
    many_to_many :orders, Sos.Orders.Order, join_through: "orders_extras"
    timestamps()
  end

  @doc false
  def changeset(extra, attrs) do
    extra
    |> cast(attrs, [:title, :description, :image, :price])
    |> validate_required([:title, :description, :image, :price])
  end
end
