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

  @doc """
  Gets a single square.

  Raises `Ecto.NoResultsError` if the Square does not exist.

  ## Examples

      iex> get_square!(123)
      %Square{}

      iex> get_square!(456)
      ** (Ecto.NoResultsError)

  """
  def get_square(row, col) do
    case Repo.get_by(Square, row: row, col: col) do
      nil -> "000000"
      square -> square
    end
  end

  @doc """
  Creates a square.

  ## Examples

      iex> create_square(%{field: value})
      {:ok, %Square{}}

      iex> create_square(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_square(attrs \\ %{}) do
    %Square{}
    |> Square.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a square.

  ## Examples

      iex> update_square(square, %{field: new_value})
      {:ok, %Square{}}

      iex> update_square(square, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_square(%Square{} = square, attrs) do
    square
    |> Square.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking square changes.

  ## Examples

      iex> change_square(square)
      %Ecto.Changeset{source: %Square{}}

  """
  def change_square(%Square{} = square) do
    Square.changeset(square, %{})
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
      [%Change{paging_token: paging_token}] -> paging_token
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

  @doc """
  Creates a change.

  ## Examples

      iex> create_change(%{field: value})
      {:ok, %Change{}}

      iex> create_change(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_change(attrs \\ %{}) do
    %Change{}
    |> Change.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a change.

  ## Examples

      iex> update_change(change, %{field: new_value})
      {:ok, %Change{}}

      iex> update_change(change, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_change(%Change{} = change, attrs) do
    change
    |> Change.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Change.

  ## Examples

      iex> delete_change(change)
      {:ok, %Change{}}

      iex> delete_change(change)
      {:error, %Ecto.Changeset{}}

  """
  def delete_change(%Change{} = change) do
    Repo.delete(change)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking change changes.

  ## Examples

      iex> change_change(change)
      %Ecto.Changeset{source: %Change{}}

  """
  def change_change(%Change{} = change) do
    Change.changeset(change, %{})
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

  def validate_change(%{"hash" => txn_hash, "paging_token" => paging_token, "source_account" => source_address, "memo_type" => "text", "memo_text" => memo_text}) do
    case parse_memo_text(memo_text) do
      {:ok, {row, col, hex_rgb}} ->
        change_change(%{
          txn_hash: txn_hash,
          paging_token: paging_token,
          source_address: source_address,
          row: row,
          col: col,
          hex_rgb: hex_rgb
        })
      :error ->
        change_change(%{
          txn_hash: txn_hash,
          paging_token: paging_token,
          source_address: source_address,
          error: "INVALID_MEMO_TEXT"
        })
    end
  end
  def validate_change(%{"hash" => txn_hash, "paging_token" => paging_token, "source_account" => source_address, "memo_type" => _memo_type}) do
    change_change(%{
      txn_hash: txn_hash,
      paging_token: paging_token,
      source_address: source_address,
      error: "INVALID_MEMO_TYPE"
    })
  end
end
