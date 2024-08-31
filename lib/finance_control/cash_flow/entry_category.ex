defmodule FinanceControl.CashFlow.EntryCategory do
  @moduledoc false

  use FinanceControl.Schema

  alias FinanceControl.CashFlow.EntryCategory

  @type entry_type() :: :debit | :credit

  @entry_types ~w(debit credit)a
  def entry_types, do: @entry_types

  schema "entry_categories" do
    field :name, :string
    field :entry_type, Ecto.Enum, values: @entry_types
  end

  @spec create_changeset(map()) :: Ecto.Changeset.t()
  def create_changeset(attrs) do
    %EntryCategory{}
    |> cast(attrs, [:name, :entry_type])
    |> unique_constraint(:name)
  end
end
