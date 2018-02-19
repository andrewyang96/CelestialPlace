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
end
