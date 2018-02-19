defmodule CelestialWeb.Grid.ChangeView do
  use CelestialWeb, :view
  alias CelestialWeb.Grid.ChangeView

  def render("index.json", %{grid_changes: grid_changes}) do
    %{data: render_many(grid_changes, ChangeView, "change.json")}
  end

  def render("show.json", %{change: change}) do
    %{data: render_one(change, ChangeView, "change.json")}
  end

  def render("change.json", %{change: change}) do
    %{id: change.id,
      txn_hash: change.txn_hash,
      amount: change.amount,
      source_address: change.source_address,
      memo_text: change.memo_text,
      row: change.row,
      col: change.col,
      error: change.error}
  end
end
