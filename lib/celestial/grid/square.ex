defmodule Celestial.Grid.Square do
  use Ecto.Schema
  import Ecto.Changeset
  alias Celestial.Grid.Square


  schema "grid_squares" do
    field :col, :integer
    field :hex_rgb, :string
    field :row, :integer
  end

  @doc false
  def changeset(%Square{} = square, attrs) do
    square
    |> cast(attrs, [:row, :col, :hex_rgb])
    |> validate_required([:row, :col, :hex_rgb])
  end
end
