defmodule Celestial.Repo.Migrations.CreateGridChanges do
  use Ecto.Migration

  def change do
    create table(:grid_changes) do
      add :txn_hash, :string
      add :amount, :decimal
      add :source_address, :string
      add :memo_text, :string, size: 28
      add :row, :integer
      add :col, :integer
      add :error, :string

      timestamps()
    end

    create unique_index("grid_changes", [:txn_hash])
    create index("grid_changes", [:row, :col])
    create index("grid_changes", [:error])
    create constraint("grid_changes", "row_must_be_in_range", check: "row >= 0 AND row < 100")
    create constraint("grid_changes", "col_must_be_in_range", check: "col >= 0 AND col < 100")
  end
end
