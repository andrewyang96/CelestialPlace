defmodule Celestial.GridTest do
  use Celestial.DataCase

  alias Celestial.Grid

  describe "grid_squares" do
    alias Celestial.Grid.Square

    @valid_attrs %{col: 42, hex_rgb: "some hex_rgb", row: 42}
    @update_attrs %{col: 43, hex_rgb: "some updated hex_rgb", row: 43}
    @invalid_attrs %{col: nil, hex_rgb: nil, row: nil}

    def square_fixture(attrs \\ %{}) do
      {:ok, square} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Grid.create_square()

      square
    end

    test "list_grid_squares/0 returns all grid_squares" do
      square = square_fixture()
      assert Grid.list_grid_squares() == [square]
    end

    test "get_square!/1 returns the square with given id" do
      square = square_fixture()
      assert Grid.get_square!(square.id) == square
    end

    test "create_square/1 with valid data creates a square" do
      assert {:ok, %Square{} = square} = Grid.create_square(@valid_attrs)
      assert square.col == 42
      assert square.hex_rgb == "some hex_rgb"
      assert square.row == 42
    end

    test "create_square/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Grid.create_square(@invalid_attrs)
    end

    test "update_square/2 with valid data updates the square" do
      square = square_fixture()
      assert {:ok, square} = Grid.update_square(square, @update_attrs)
      assert %Square{} = square
      assert square.col == 43
      assert square.hex_rgb == "some updated hex_rgb"
      assert square.row == 43
    end

    test "update_square/2 with invalid data returns error changeset" do
      square = square_fixture()
      assert {:error, %Ecto.Changeset{}} = Grid.update_square(square, @invalid_attrs)
      assert square == Grid.get_square!(square.id)
    end

    test "delete_square/1 deletes the square" do
      square = square_fixture()
      assert {:ok, %Square{}} = Grid.delete_square(square)
      assert_raise Ecto.NoResultsError, fn -> Grid.get_square!(square.id) end
    end

    test "change_square/1 returns a square changeset" do
      square = square_fixture()
      assert %Ecto.Changeset{} = Grid.change_square(square)
    end
  end
end
