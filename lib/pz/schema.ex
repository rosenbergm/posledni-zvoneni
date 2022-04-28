defmodule PZ.Schema do
  @moduledoc "This module overrides the `__using__` function in the `Ecto.Schema` module, allowing us to cast all `%Ecto.Association.NotLoaded{}` to `nil`."

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @type t :: %__MODULE__{}
      defimpl Jason.Encoder do
        def encode(struct, opts) do
          Map.from_struct(struct)
          |> Map.delete(:__meta__)
          |> Map.delete(:__schema__)
          |> Map.delete(:__struct__)
          |> Enum.into(
            %{},
            &case &1 do
              {key, %Ecto.Association.NotLoaded{}} ->
                {key, nil}

              {key, value} ->
                {key, value}
            end
          )
          |> Jason.Encode.map(opts)
        end
      end
    end
  end
end
