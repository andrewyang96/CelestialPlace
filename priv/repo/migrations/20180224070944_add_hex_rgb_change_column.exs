defmodule Celestial.Repo.Migrations.AddHexRgbChangeColumn do
  use Ecto.Migration

  def change do
    alter table(:grid_changes) do
      add :hex_rgb, :string
    end
  end
end
