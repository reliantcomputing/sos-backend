defmodule Sos.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :status, :string
      add :rejected, :boolean, default: false, null: false
      add :rejected_reason, :text, null: true
      add :sit_id, references(:sits, on_delete: :delete_all)
      timestamps()
    end

  end
end
