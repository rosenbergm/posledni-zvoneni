defmodule PZ.Schema.Class do
  use PZ.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "classes" do
    field :name, :string

    has_many :transfers, PZ.Schema.Transfer

    timestamps()
  end
end
