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

  describe "grid_changes" do
    alias Celestial.Grid.Change

    @valid_attrs %{amount: "120.5", col: 42, error: "some error", memo_text: "some memo_text", row: 42, source_address: "some source_address", txn_hash: "some txn_hash"}
    @update_attrs %{amount: "456.7", col: 43, error: "some updated error", memo_text: "some updated memo_text", row: 43, source_address: "some updated source_address", txn_hash: "some updated txn_hash"}
    @invalid_attrs %{amount: nil, col: nil, error: nil, memo_text: nil, row: nil, source_address: nil, txn_hash: nil}

    def change_fixture(attrs \\ %{}) do
      {:ok, change} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Grid.create_change()

      change
    end

    test "list_grid_changes/0 returns all grid_changes" do
      change = change_fixture()
      assert Grid.list_grid_changes() == [change]
    end

    test "get_change!/1 returns the change with given id" do
      change = change_fixture()
      assert Grid.get_change!(change.id) == change
    end

    test "create_change/1 with valid data creates a change" do
      assert {:ok, %Change{} = change} = Grid.create_change(@valid_attrs)
      assert change.amount == Decimal.new("120.5")
      assert change.col == 42
      assert change.error == "some error"
      assert change.memo_text == "some memo_text"
      assert change.row == 42
      assert change.source_address == "some source_address"
      assert change.txn_hash == "some txn_hash"
    end

    test "create_change/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Grid.create_change(@invalid_attrs)
    end

    test "update_change/2 with valid data updates the change" do
      change = change_fixture()
      assert {:ok, change} = Grid.update_change(change, @update_attrs)
      assert %Change{} = change
      assert change.amount == Decimal.new("456.7")
      assert change.col == 43
      assert change.error == "some updated error"
      assert change.memo_text == "some updated memo_text"
      assert change.row == 43
      assert change.source_address == "some updated source_address"
      assert change.txn_hash == "some updated txn_hash"
    end

    test "update_change/2 with invalid data returns error changeset" do
      change = change_fixture()
      assert {:error, %Ecto.Changeset{}} = Grid.update_change(change, @invalid_attrs)
      assert change == Grid.get_change!(change.id)
    end

    test "delete_change/1 deletes the change" do
      change = change_fixture()
      assert {:ok, %Change{}} = Grid.delete_change(change)
      assert_raise Ecto.NoResultsError, fn -> Grid.get_change!(change.id) end
    end

    test "change_change/1 returns a change changeset" do
      change = change_fixture()
      assert %Ecto.Changeset{} = Grid.change_change(change)
    end
  end
end
