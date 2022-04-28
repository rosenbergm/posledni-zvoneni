defmodule PZ.MigrationRunner do
  @moduledoc "Module that provides a GenServer for running migrations"

  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(opts) do
    unless Application.get_env(:pz, :env) == :dev do
      path = Application.app_dir(:pz, "priv/repo/migrations")
      Ecto.Migrator.run(PZ.Repo, path, :up, all: true)
    end

    {:ok, opts}
  end
end
