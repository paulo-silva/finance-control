defmodule FinanceControl.Repo.Migrations.CreateEntriesTables do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE entry_types AS ENUM ('debit', 'credit');", ""

    create table(:entry_categories) do
      add :name, :citext, null: false
      add :entry_type, :entry_types, null: false
    end

    create unique_index(:entry_categories, :name)

    create table(:entries) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :category_id, references(:entry_categories, on_delete: :nothing), null: false
      add :amount_in_cents, :bigint, null: false
      add :made_at, :utc_datetime_usec, null: false

      timestamps()
    end
  end
end
