defmodule PZWeb.TransfersController do
  use PZWeb, :controller

  alias PZ.{Classes, Transfers}
  alias PZWeb.Endpoint

  def add(conn, %{"amount" => _, "class_id" => _, "country_id" => _, "token" => token} = params) do
    if token == System.get_env("ONDRA_TOKEN") do
      case Transfers.add(params) do
        {:ok, transfer} ->
          Endpoint.broadcast("points", "change", Classes.get_class_order())

          json(conn, transfer)

        {:error, _} ->
          conn
          |> send_resp(500, "Something went wrong")
      end
    else
      conn
      |> send_resp(401, "Piss off")
    end
  end

  def add(conn, _params) do
    conn
    |> send_resp(400, "Bad request")
  end

  def get(conn, _params) do
    json(conn, Transfers.get())
  end
end
