defmodule Sos.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:auth_users) do
      add :emp_id, :string
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :street_name, :string
      add :house, :string
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      add :role_id, references(:roles, on_delete: :nothing), null: false
      timestamps()
    end

    create unique_index(:auth_users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:auth_users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
