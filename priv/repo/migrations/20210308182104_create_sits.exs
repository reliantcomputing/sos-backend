defmodule Sos.Repo.Migrations.CreateSits do
  use Ecto.Migration

  def change do
    create table(:sits) do
      add :sit_number, :string

      timestamps()
    end

  end
end
