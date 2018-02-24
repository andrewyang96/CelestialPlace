defmodule Celestial.Jobs.TxnUpdater do
  use GenServer

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
    txns = body["_embedded"]["records"]

    # process txns
    IO.inspect(txns)

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :ping, 2_000)
  end
end
