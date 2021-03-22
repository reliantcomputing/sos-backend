defmodule Sos.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :seen, :boolean, default: false, null: false
      add :text, :string
      add :message_from, :string

      timestamps()
    end

  end
end
