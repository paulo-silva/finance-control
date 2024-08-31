defmodule FinanceControl.CashFlow do
  @moduledoc "Cash Flow context"

  import Ecto.Query

  alias FinanceControl.CashFlow.Entry
  alias FinanceControl.CashFlow.EntryCategory
  alias FinanceControl.Repo

  @entry_types EntryCategory.entry_types()

  @spec create_entry_category(String.t(), EntryCategory.entry_type()) ::
          {:ok, Entry.t()} | {:error, Ecto.Changeset.t()}
  def create_entry_category(name, entry_type) do
    %{name: name, entry_type: entry_type}
    |> EntryCategory.create_changeset()
    |> Repo.insert()
  end

  @spec load_entry_categories(EntryCategory.entry_type()) :: list(EntryCategory.t())
  def load_entry_categories(entry_type) when entry_type in @entry_types do
    EntryCategory
    |> where([ec], ec.entry_type == ^entry_type)
    |> Repo.all()
  end

  @spec create_entry(Ecto.UUID.t(), Ecto.UUID.t(), integer(), DateTime.t()) ::
          {:ok, Entry.t()} | {:error, Ecto.Changeset.t()}
  def create_entry(user_id, entry_category_id, amount_in_cents, made_at) do
    %{
      user_id: user_id,
      category_id: entry_category_id,
      amount_in_cents: amount_in_cents,
      made_at: made_at
    }
    |> Entry.create_changeset()
    |> Repo.insert()
  end

  def calculate_balance(user_id, start_date, end_date \\ DateTime.utc_now()) do
    user_id
    |> load_entries_by_period(start_date, end_date)
    |> join(:inner, [e], ec in assoc(e, :category), as: :category)
    |> select([e, category: c], {e.amount_in_cents, c.entry_type})
    |> Repo.all()
    |> Enum.reduce(0, fn
      {amount_in_cents, :debit}, sum -> sum + -amount_in_cents
      {amount_in_cents, :credit}, sum -> sum + amount_in_cents
    end)
  end

  def load_entries_by_period(user_id, start_date, end_date) do
    Entry
    |> where([e], e.user_id == ^user_id)
    |> where([e], e.made_at >= ^start_date and e.made_at <= ^end_date)
    |> order_by([e], e.made_at)
  end
end
