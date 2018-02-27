defmodule Celestial.Grid do
  @moduledoc """
  The Grid context.
  """

  import Ecto.Query, warn: false
  alias Celestial.Repo

  alias Celestial.Grid.Square

  @doc """
  Returns the list of grid_squares.

  ## Examples

      iex> list_grid_squares()
      [%Square{}, ...]

  """
  def list_grid_squares do
    Repo.all(Square)
    |> List.foldl(%{}, fn(square, acc) ->
      Map.merge(acc, %{{square.row, square.col} => square.hex_rgb})
    end)
    |> square_map_to_grid
  end

  defp square_map_to_grid(hex_rgb_map) do
    for row <- 0..999 do
      for col <- 0..999 do
        case hex_rgb_map[{row, col}] do
          nil -> "000000"
          hex_rgb -> hex_rgb
        end
      end
    end
  end

  def get_square_by_coords(row, col) do
    Repo.get_by(Square, row: row, col: col)
  end

  def create_or_update_square_by_coords_changeset(row, col, hex_rgb) do
    case get_square_by_coords(row, col) do
      nil -> %Square{row: row, col: col, hex_rgb: hex_rgb}
      square -> square
    end
    |> Square.changeset(%{row: row, col: col, hex_rgb: hex_rgb})
  end

  alias Celestial.Grid.Change

  @doc """
  Returns the list of grid_changes.

  ## Examples

      iex> list_grid_changes()
      [%Change{}, ...]

  """
  def list_grid_changes do
    Repo.all(Change)
  end

  def get_latest_paging_token do
    import Ecto.Query

    query = from change in "grid_changes",
      order_by: [desc: change.inserted_at],
      limit: 1,
      select: change.paging_token

    case Repo.all(query) do
      [] -> nil
      [paging_token] -> paging_token
    end
  end

  @doc """
  Gets a single change.

  Raises `Ecto.NoResultsError` if the Change does not exist.

  ## Examples

      iex> get_change!(123)
      %Change{}

      iex> get_change!(456)
      ** (Ecto.NoResultsError)

  """
  def get_change!(id), do: Repo.get!(Change, id)

  def create_change_update_square_txn(changeset, row, col, hex_rgb) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:change, changeset)
    |> Ecto.Multi.insert_or_update(
      :square, create_or_update_square_by_coords_changeset(row, col, hex_rgb))
    |> Repo.transaction()
  end

  @memo_text_regex ~r/^(?<row>[0-9]{1,2})[,;](?<col>[0-9]{1,2})[,;]#?(?<hex_rgb>[0-9a-f]{6}$)/i

  def parse_memo_text(memo_text) do
    case Regex.named_captures(@memo_text_regex, memo_text) do
      %{"row" => row, "col" => col, "hex_rgb" => hex_rgb} ->
        {:ok, {String.to_integer(row), String.to_integer(col), String.downcase(hex_rgb)}}
      nil ->
        :error
    end
  end

  def validate_change(%{"hash" => txn_hash, "paging_token" => paging_token, "source_account" => source_address, "memo_type" => "text", "memo" => memo_text}) do
    case parse_memo_text(memo_text) do
      {:ok, {row, col, hex_rgb}} ->
        {
          :valid,
          %Change{}
          |> Change.changeset(%{
            txn_hash: txn_hash,
            paging_token: paging_token,
            source_address: source_address,
            row: row,
            col: col,
            hex_rgb: hex_rgb
          })
        }
      :error ->
        {
          :invalid,
          %Change{}
          |> Change.changeset(%{
            txn_hash: txn_hash,
            paging_token: paging_token,
            source_address: source_address,
            error: "INVALID_MEMO_TEXT"
          })
        }
    end
  end
  def validate_change(%{"hash" => txn_hash, "paging_token" => paging_token, "source_account" => source_address, "memo_type" => _memo_type}) do
    {
      :invalid,
      %Change{}
      |> Change.changeset(%{
        txn_hash: txn_hash,
        paging_token: paging_token,
        source_address: source_address,
        error: "INVALID_MEMO_TYPE"
      })
    }
  end
end
