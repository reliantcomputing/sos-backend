defmodule Sos.Repo.Migrations.AddOrderMenus do
  use Ecto.Migration

  def change do
    create table(:orders_menus) do
      add :order_id, references(:orders, on_delete: :nothing)
      add :menu_id, references(:menus, on_delete: :nothing)
    end

    create index(:orders_menus, [:order_id])
    create index(:orders_menus, [:menu_id])
    end
end
