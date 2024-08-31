defmodule FinanceControl.Repo do
  use Ecto.Repo,
    otp_app: :finance_control,
    adapter: Ecto.Adapters.Postgres

  alias FinanceControl.Repo

  def find(schema, id) do
    schema |> Repo.get(id) |> handle_find_result()
  end

  def find_by(schema, filters) do
    schema |> Repo.get_by(filters) |> handle_find_result()
  end

  defp handle_find_result(nil), do: {:error, :not_found}
  defp handle_find_result(%_{} = record), do: {:ok, record}
end
