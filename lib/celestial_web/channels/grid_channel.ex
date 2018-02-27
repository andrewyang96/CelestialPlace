defmodule CelestialWeb.GridChannel do
  use CelestialWeb, :channel
  alias Celestial.Grid

  def join("grid", _params, socket) do
    {:ok, %{grid: Grid.list_grid_squares()}, socket}
  end
end
