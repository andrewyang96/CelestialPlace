defmodule Celestial.Grid.Change do
  use Ecto.Schema
  import Ecto.Changeset
  alias Celestial.Grid.Change


  schema "grid_changes" do
    field :amount, :decimal
    field :col, :integer
    field :error, :string
    field :memo_text, :string
    field :row, :integer
    field :source_address, :string
    field :txn_hash, :string
    field :paging_token, :string

    timestamps()
  end

  @doc false
  def changeset(%Change{} = change, attrs) do
    change
    |> cast(attrs, [:txn_hash, :paging_token, :amount, :source_address, :memo_text, :row, :col, :error])
    |> validate_required([:txn_hash, :paging_token, :amount, :source_address])
  end
end
