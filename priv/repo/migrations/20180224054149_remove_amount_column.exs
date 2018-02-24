defmodule Celestial.Repo.Migrations.RemoveAmountColumn do
  use Ecto.Migration

  def change do
    alter table(:grid_changes) do
      remove :amount
    end
  end
end
