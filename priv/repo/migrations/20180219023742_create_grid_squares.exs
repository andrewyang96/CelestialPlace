defmodule Celestial.Repo.Migrations.CreateGridSquares do
  use Ecto.Migration

  def change do
    create table(:grid_squares) do
      add :row, :integer
      add :col, :integer
      add :hex_rgb, :string
    end

    create unique_index("grid_squares", [:row, :col])
    create constraint("grid_squares", "row_must_be_in_range", check: "row >= 0 AND row < 100")
    create constraint("grid_squares", "col_must_be_in_range", check: "col >= 0 AND col < 100")
  end
end
