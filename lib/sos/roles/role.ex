defmodule Sos.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :description, :string
    field :name, :string
    has_many :users, Sos.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
