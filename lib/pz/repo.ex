defmodule PZ.Repo do
  use Ecto.Repo,
    otp_app: :pz,
    adapter: Ecto.Adapters.Postgres
end
