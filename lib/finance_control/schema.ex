defmodule FinanceControl.Schema do
  @moduledoc """
  A FinanceControl Ecto schema

  * Primary keys are UUID binary IDs
  * Timestamps are in UTC and include microseconds

  Pass in `persisted: false` for schemas that aren't backed by a database table.
  """

  defmacro __using__(opts) do
    persisted = Keyword.get(opts, :persisted, true)

    shared =
      quote do
        use Ecto.Schema

        import Ecto.Changeset
        import FinanceControl.Schema

        alias Ecto.Changeset

        @type t :: %__MODULE__{}
      end

    rest =
      if persisted do
        quote do
          import Ecto.Query

          @primary_key {:id, Ecto.UUID, autogenerate: true}
          @foreign_key_type Ecto.UUID
          @timestamps_opts [type: :utc_datetime_usec]
        end
      else
        quote do
          @primary_key false
        end
      end

    [shared, rest]
  end

  @doc """
  Trim whitespace from provided field values on changeset.
  """
  @spec trim_whitespace(Ecto.Changeset.t(), list()) :: Ecto.Changeset.t()
  def trim_whitespace(%{valid?: true} = changeset, fields) do
    Enum.reduce(fields, changeset, fn field, changeset ->
      Ecto.Changeset.update_change(changeset, field, &String.trim/1)
    end)
  end

  def trim_whitespace(changeset, _fields), do: changeset
end
