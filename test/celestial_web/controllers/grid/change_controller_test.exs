defmodule CelestialWeb.Grid.ChangeControllerTest do
  use CelestialWeb.ConnCase

  alias Celestial.Grid
  alias Celestial.Grid.Change

  @create_attrs %{amount: "120.5", col: 42, error: "some error", memo_text: "some memo_text", row: 42, source_address: "some source_address", txn_hash: "some txn_hash"}
  @update_attrs %{amount: "456.7", col: 43, error: "some updated error", memo_text: "some updated memo_text", row: 43, source_address: "some updated source_address", txn_hash: "some updated txn_hash"}
  @invalid_attrs %{amount: nil, col: nil, error: nil, memo_text: nil, row: nil, source_address: nil, txn_hash: nil}

  def fixture(:change) do
    {:ok, change} = Grid.create_change(@create_attrs)
    change
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all grid_changes", %{conn: conn} do
      conn = get conn, grid_change_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create change" do
    test "renders change when data is valid", %{conn: conn} do
      conn = post conn, grid_change_path(conn, :create), change: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, grid_change_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "amount" => "120.5",
        "col" => 42,
        "error" => "some error",
        "memo_text" => "some memo_text",
        "row" => 42,
        "source_address" => "some source_address",
        "txn_hash" => "some txn_hash"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, grid_change_path(conn, :create), change: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update change" do
    setup [:create_change]

    test "renders change when data is valid", %{conn: conn, change: %Change{id: id} = change} do
      conn = put conn, grid_change_path(conn, :update, change), change: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, grid_change_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "amount" => "456.7",
        "col" => 43,
        "error" => "some updated error",
        "memo_text" => "some updated memo_text",
        "row" => 43,
        "source_address" => "some updated source_address",
        "txn_hash" => "some updated txn_hash"}
    end

    test "renders errors when data is invalid", %{conn: conn, change: change} do
      conn = put conn, grid_change_path(conn, :update, change), change: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete change" do
    setup [:create_change]

    test "deletes chosen change", %{conn: conn, change: change} do
      conn = delete conn, grid_change_path(conn, :delete, change)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, grid_change_path(conn, :show, change)
      end
    end
  end

  defp create_change(_) do
    change = fixture(:change)
    {:ok, change: change}
  end
end
