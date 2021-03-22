defmodule Sos.Repo.Migrations.CreateOrderExtras do
  use Ecto.Migration

  def change do
    create table(:order_extras) do
      add :qty, :integer

      add :extra_id, references(:extras, on_delete: :nothing), null: true
      add :order_id, references(:orders, on_delete: :nothing)
      timestamps()
    end

  end
end
