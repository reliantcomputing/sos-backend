defmodule Sos.Repo.Migrations.AddOrdersExtras do
  use Ecto.Migration

  def change do
    create table(:orders_extras) do
      add :order_id, references(:orders, on_delete: :nothing)
      add :extra_id, references(:extras, on_delete: :nothing)
    end

    create index(:orders_extras, [:order_id])
    create index(:orders_extras, [:extra_id])
  end
end
