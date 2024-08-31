defmodule FinanceControl.CashFlow.Entry do
  @moduledoc false

  use FinanceControl.Schema

  alias FinanceControl.Auth.User
  alias FinanceControl.CashFlow.Entry
  alias FinanceControl.CashFlow.EntryCategory

  schema "entries" do
    belongs_to :user, User
    belongs_to :category, EntryCategory

    field :amount_in_cents, :integer
    field :made_at, :utc_datetime_usec

    timestamps()
  end

  @spec create_changeset(map()) :: Ecto.Changeset.t()
  def create_changeset(attrs) do
    %Entry{}
    |> cast(attrs, [:user_id, :category_id, :amount_in_cents, :made_at])
    |> validate_required([:user_id, :category_id, :amount_in_cents, :made_at])
  end
end
