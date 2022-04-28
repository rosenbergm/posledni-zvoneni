defmodule PZWeb.ClassesController do
  use PZWeb, :controller

  alias PZ.Classes

  def get(conn, _params) do
    json(conn, Classes.get_all())
  end
end
