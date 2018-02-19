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
  def get_square!(id), do: Repo.get!(Square, id)

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
  Deletes a Square.

  ## Examples

      iex> delete_square(square)
      {:ok, %Square{}}

      iex> delete_square(square)
      {:error, %Ecto.Changeset{}}

  """
  def delete_square(%Square{} = square) do
    Repo.delete(square)
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
end
