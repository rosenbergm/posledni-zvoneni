defmodule PZ.Schema.Country do
  use PZ.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "countries" do
    field :name, :string

    timestamps()
  end
end
