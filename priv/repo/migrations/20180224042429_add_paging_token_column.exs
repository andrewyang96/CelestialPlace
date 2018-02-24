defmodule Celestial.Repo.Migrations.AddPagingTokenColumn do
  use Ecto.Migration

  def change do
    alter table(:grid_changes) do
      add :paging_token, :string
    end
  end
end
