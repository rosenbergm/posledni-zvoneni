defmodule PZ.Classes do
  alias PZ.Repo
  alias PZ.Schema.Class

  import Ecto.Query

  def get_all do
    Repo.all(Class)
  end

  def get_class_order do
    from(c in Class,
      left_join: t in assoc(c, :transfers),
      preload: [transfers: t]
    )
    |> Repo.all()
    |> Enum.map(fn class ->
      %{
        id: class.id,
        name: class.name,
        points: class.transfers |> Enum.map(& &1.amount) |> Enum.sum()
      }
    end)
    |> Enum.sort_by(& &1.points)
  end
end
