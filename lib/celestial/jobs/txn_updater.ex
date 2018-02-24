defmodule Celestial.Jobs.TxnUpdater do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{last_txn_hash: nil})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:ping, %{last_txn_hash: last_txn_hash}) do
    # determine last txn hash
    # query txns from horizon
    # process txns from horizon, update last_txn_hash
    last_txn_hash_updated = nil
    IO.puts("work!")
    schedule_work()
    {:noreply, %{last_txn_hash: last_txn_hash_updated}}
  end

  defp schedule_work() do
    Process.send_after(self(), :ping, 2_000)
  end
end
