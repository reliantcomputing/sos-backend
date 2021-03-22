defmodule Sos.Repo.Migrations.CreateExtras do
  use Ecto.Migration

  def change do
    create table(:extras) do
      add :title, :string
      add :description, :string
      add :image, :string
      add :price, :decimal

      timestamps()
    end

  end
end
