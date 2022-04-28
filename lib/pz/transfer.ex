defmodule PZ.Transfers do
  alias PZ.Repo
  alias PZ.Schema.Transfer

  def add(params) do
    %Transfer{}
    |> Transfer.create(params)
    |> Repo.insert()
  end

  def get do
    Repo.all(Transfer)
  end
end
