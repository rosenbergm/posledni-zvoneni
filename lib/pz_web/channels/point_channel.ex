defmodule HelloWeb.PointChannel do
  use Phoenix.Channel

  def join("points", _message, socket) do
    {:ok, socket}
  end
end
