defmodule Sos.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus) do
      add :title, :string
      add :description, :string
      add :image, :string
      add :price, :decimal

      timestamps()
    end

  end
end
