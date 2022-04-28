defmodule PZ.Schema.Transfer do
  use PZ.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transfers" do
    field :amount, :integer

    belongs_to :class, PZ.Schema.Class, foreign_key: :class_id, type: :binary_id
    belongs_to :country, PZ.Schema.Country, foreign_key: :country_id, type: :binary_id

    timestamps()
  end

  def create(transfer, attrs) do
    transfer
    |> cast(attrs, [:amount, :class_id, :country_id])
    |> validate_required([:amount, :class_id, :country_id])
  end
end
