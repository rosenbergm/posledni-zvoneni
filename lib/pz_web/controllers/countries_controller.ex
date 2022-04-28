defmodule PZWeb.CountriesController do
  use PZWeb, :controller

  alias PZ.Countries

  def get(conn, _params) do
    json(conn, Countries.get_all())
  end
end
