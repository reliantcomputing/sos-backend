defmodule Sos.Repo.Migrations.CreateOrderMenus do
  use Ecto.Migration

  def change do
    create table(:order_menus) do
      add :qty, :integer

      add :order_id, references(:orders, on_delete: :nothing)
      add :menu_id, references(:menus, on_delete: :nothing), null: true
      timestamps()
    end

  end
end
