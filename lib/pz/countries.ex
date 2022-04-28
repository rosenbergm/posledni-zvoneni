defmodule PZ.Countries do
  alias PZ.Repo
  alias PZ.Schema.Country

  def get_all do
    Repo.all(Country)
  end
end
