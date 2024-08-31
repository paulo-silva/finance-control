alias FinanceControl.Auth
alias FinanceControl.CashFlow
alias FinanceControl.Repo

Repo.transaction(fn ->
  {:ok, user} = Auth.create_user("paulo.silva@gmail.com")

  [
    {"Salário", "credit"},
    {"Mercado", "debit"},
    {"Aluguel", "debit"},
    {"Conta de Luz", "debit"},
    {"Conta de Água", "debit"}
  ]
  |> Enum.each(fn {name, entry_type} ->
    {:ok, _} = CashFlow.create_entry_category(name, entry_type)
  end)

  [salary_category] = CashFlow.load_entry_categories(:credit)

  debit_categories = CashFlow.load_entry_categories(:debit)

  {:ok, _} = CashFlow.create_entry(user.id, salary_category.id, 2_500 * 100, DateTime.utc_now())

  Enum.each(debit_categories, fn debit_category ->
    CashFlow.create_entry(
      user.id,
      debit_category.id,
      Enum.random(100..500//100) * 100,
      DateTime.utc_now()
    )
  end)
end)
