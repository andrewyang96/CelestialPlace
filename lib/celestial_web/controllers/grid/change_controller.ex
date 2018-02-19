defmodule CelestialWeb.Grid.ChangeController do
  use CelestialWeb, :controller

  alias Celestial.Grid
  alias Celestial.Grid.Change

  action_fallback CelestialWeb.FallbackController

  def index(conn, _params) do
    grid_changes = Grid.list_grid_changes()
    render(conn, "index.json", grid_changes: grid_changes)
  end

  def create(conn, %{"change" => change_params}) do
    with {:ok, %Change{} = change} <- Grid.create_change(change_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", change_path(conn, :show, change))
      |> render("show.json", change: change)
    end
  end

  def show(conn, %{"id" => id}) do
    change = Grid.get_change!(id)
    render(conn, "show.json", change: change)
  end

  def update(conn, %{"id" => id, "change" => change_params}) do
    change = Grid.get_change!(id)

    with {:ok, %Change{} = change} <- Grid.update_change(change, change_params) do
      render(conn, "show.json", change: change)
    end
  end

  def delete(conn, %{"id" => id}) do
    change = Grid.get_change!(id)
    with {:ok, %Change{}} <- Grid.delete_change(change) do
      send_resp(conn, :no_content, "")
    end
  end
end
