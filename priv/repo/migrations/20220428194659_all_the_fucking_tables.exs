defmodule PZ.Repo.Migrations.AllTheFuckingTables do
  use Ecto.Migration

  def change do
    create table(:classes, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add(:name, :string)

      timestamps()
    end

    create table(:countries, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add(:name, :string)

      timestamps()
    end

    create table(:transfers, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add(:amount, :integer)

      add :class_id, references(:classes, on_delete: :delete_all, type: :uuid), null: false
      add :country_id, references(:countries, on_delete: :delete_all, type: :uuid), null: false

      timestamps()
    end
  end
end
