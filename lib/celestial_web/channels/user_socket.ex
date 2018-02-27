defmodule CelestialWeb.UserSocket do
  use Phoenix.Socket

  channel "grid", CelestialWeb.GridChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
