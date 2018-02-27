defmodule Celestial.Jobs.TxnUpdater do
  use GenServer

  alias Celestial.Grid

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:ping, state) do
    # determine last txn hash
    latest_paging_token = Celestial.Grid.get_latest_paging_token()

    # query txns from horizon
    {:ok, body} =
      Application.get_env(:stellar, :address)
      |> Stellar.Transactions.all_for_account(cursor: latest_paging_token, limit: 200)
    txns =
      body["_embedded"]["records"]
      |> Enum.reject(
        fn txn -> txn["source_address"] == Application.get_env(:stellar, :address) end)

    # process txns
    for txn <- txns do
      case Grid.validate_change(txn) do
        {:valid, change} ->
          Grid.create_change_update_square_txn(change)
          broadcast_square_update!(txn)
        {:invalid, change} ->
          Celestial.Repo.insert(change)
      end
    end

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :ping, 2_000)
  end

  defp broadcast_square_update!(%{"row" => row, "col" => col, "hex_rgb" => hex_rgb}) do
    CelestialWeb.Endpoint.broadcast!("grid", "grid:update", %{"row" => row, "col" => col, "hex_rgb" => hex_rgb})
  end
end
