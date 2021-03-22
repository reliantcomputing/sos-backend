defmodule Sos.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :name, :string
      add :closed, :boolean
      add :assistant, :string
      add :user_id, references(:auth_users, on_delete: :delete_all)
      add :sit_id, references(:sits, on_delete: :delete_all)
      timestamps()
    end

  end
end
