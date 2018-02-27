defmodule CelestialWeb.PageController do
  use CelestialWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def instructions(conn, _params) do
    render conn, "instructions.html"
  end
end
