defmodule Sos.Menus.Menu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "menus" do
    field :description, :string
    field :image, :string
    field :price, :decimal
    field :title, :string
    many_to_many :orders, Sos.Orders.Order, join_through: "orders_menus"
    timestamps()
  end

  @doc false
  def changeset(menu, attrs) do
    menu
    |> cast(attrs, [:title, :description, :image, :price])
    |> validate_required([:title, :description, :image, :price])
  end
end
